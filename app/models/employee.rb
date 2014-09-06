# == Schema Information
#
# Table name: employees
#
#  id                                   :integer          not null, primary key
#  user_id                              :integer
#  legacy_id                            :string           default("")
#  first_name                           :string           default("")
#  last_name                            :string           default("")
#  email                                :string           default("")
#  phone                                :string           default("")
#  address1                             :string           default("")
#  address2                             :string           default("")
#  address_city                         :string           default("")
#  address_state                        :string           default("")
#  address_zip                          :string           default("")
#  title                                :string           default("")
#  pay_hourly                           :decimal(8, 2)    default("0.0")
#  pay_daily                            :decimal(8, 2)    default("0.0")
#  hire_date                            :date
#  term_date                            :date
#  fed_filing_status                    :string           default("")
#  ca_filing_status                     :string           default("")
#  fed_allowances                       :integer          default("0")
#  ca_allowances                        :integer          default("0")
#  dob                                  :date
#  gender                               :string           default("")
#  active                               :boolean          default("true")
#  notes                                :text             default("")
#  created_at                           :datetime
#  updated_at                           :datetime
#  daily_quota                          :decimal(8, 2)    default("0.0")
#  shifts_lifetime                      :decimal(8, 2)    default("0.0")
#  shifts_this_pay_period               :decimal(8, 2)    default("0.0")
#  shifts_this_week                     :decimal(8, 2)    default("0.0")
#  fundraising_shifts_lifetime          :decimal(8, 2)    default("0.0")
#  fundraising_shifts_this_pay_period   :decimal(8, 2)    default("0.0")
#  fundraising_shifts_this_week         :decimal(8, 2)    default("0.0")
#  donations_lifetime                   :decimal(8, 2)    default("0.0")
#  donations_this_pay_period            :decimal(8, 2)    default("0.0")
#  donations_this_week                  :decimal(8, 2)    default("0.0")
#  successful_donations_lifetime        :decimal(8, 2)    default("0.0")
#  successful_donations_this_pay_period :decimal(8, 2)    default("0.0")
#  successful_donations_this_week       :decimal(8, 2)    default("0.0")
#  raised_lifetime                      :decimal(8, 2)    default("0.0")
#  raised_this_pay_period               :decimal(8, 2)    default("0.0")
#  raised_this_week                     :decimal(8, 2)    default("0.0")
#  average_lifetime                     :decimal(8, 2)    default("0.0")
#  average_this_pay_period              :decimal(8, 2)    default("0.0")
#  average_this_week                    :decimal(8, 2)    default("0.0")
#

class Employee < ActiveRecord::Base

  has_paper_trail

  default_scope { order(created_at: :desc) }

  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods
  include Cleaning

  ## RELATIONSHIPS
  belongs_to :user
  has_many :shifts, dependent: :destroy
  has_many :donations, through: :shifts
  has_many :payments, through: :shifts
  has_many :deposit_batches
  has_many :paychecks

  ## VALIDATIONS

  validates :first_name, :last_name, presence: { message: "required" },
            length: { maximum: 25, minimum: 2, 
                      message: "must be between 2 and 25 characters" }

  validates :email,
            format: { with: VALID_EMAIL_REGEX }

  validates :phone, presence: { message: "required" },
            format: { with: PHONE_REGEX, message: "must be 10 digits" }

  validates :address1, :address_city,
            presence: { message: "required" }

  validates :fed_filing_status, :ca_filing_status, :hire_date, :dob, :title,
            presence: { message: "required" }

  validates :term_date,
            date: { after: :hire_date },
            allow_blank: true

  validates :address_state, presence: { message: "required." },
            format: { with: STATE_REGEX,
                      message: "must be two upper-case letters" }

  validates :address_zip, presence: { message: "required" },
            length: { is: 5 },
            numericality: { message: "must be 5 digits" }

  validates :gender, presence: { message: "required" },
            format: { with: GENDER_REGEX, message: "must be either M for F" }

  validates :pay_hourly, :pay_daily,
            numericality: { message: "must be a number" },
            allow_blank: true

  validate :pay_validator

  #validate :min_wage_validator

  validates :fed_allowances, :ca_allowances,  presence: { message: "required" },
            length: { is: 1 },
            numericality: { message: "must be a single digit" }


  ## WRITERS
  def email=(email)
    write_attribute(:email, email.downcase)
  end

  def phone=(phone)
    write_attribute(:phone, clean_phone(phone))
  end


  ## SCOPES
  def self.active
    Employee.where(active: true)
  end

  def self.field_managers
    Employee.where(title: "field_manager")
  end

  ## FUNDRAISING STATISTICS

  def self.statistics(employee)
    shifts = employee.shifts
    shifts_this_week = shifts.where(date: (Date.today.beginning_of_week..Date.today))
    fundraising_shifts = shifts.select { |s| s.fundraising_shift }
    fundraising_shifts_this_week = shifts_this_week.select { |s| s.fundraising_shift }
    donations = employee.donations
    successful_donations = donations.select { |d| d.captured }
    donations_this_week = donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
    successful_donations_this_week = successful_donations.select { |d| (Date.today.beginning_of_week..Date.today).include?(d.shift.date) }
    raised_lifetime = successful_donations.sum(&:total_value)
    raised_this_week = successful_donations_this_week.sum(&:total_value)
    {
        shifts_lifetime: shifts.count,
        shifts_this_week: shifts_this_week.count,
        fundraising_shifts_lifetime: fundraising_shifts.count,
        fundraising_shifts_this_week: fundraising_shifts_this_week.count,
        donations_lifetime: donations.count,
        donations_this_week: donations_this_week.count,
        successful_donations_lifetime: successful_donations.count,
        successful_donations_this_week:  successful_donations_this_week.count,
        raised_lifetime: raised_lifetime,
        raised_this_week: raised_this_week,
        average_lifetime: self.calculate_average(raised_lifetime, fundraising_shifts.count),
        average_this_week: self.calculate_average(raised_this_week, fundraising_shifts_this_week.count)
    }
  end

  def self.calculate_average(raised, shifts_count)
    shifts_count > 0 ? raised / shifts_count : 0
  end


  private
    def pay_validator
      if ( pay_hourly > 0 && pay_daily > 0 ) || ( pay_hourly == 0 && pay_daily == 0 )
        errors.add(:pay_hourly,
                   "Specify an hourly or a daily rate, but not both.")
        errors.add(:pay_daily,
                   "Specify an hourly or a daily rate, but not both.")
      end
    end

    # def min_wage_validator
    #   if pay_hourly < Staffnet2::Application.config.minimum_wage
    #     errors.add(:pay_hourly, "Hourly pay must be greater than #{Staffnet2::Application.config.minimum_wage.to_s}" )
    #   end
    # end
end
