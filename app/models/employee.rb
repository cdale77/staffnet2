# == Schema Information
#
# Table name: employees
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  legacy_id         :string(255)      default("")
#  first_name        :string(255)      default("")
#  last_name         :string(255)      default("")
#  email             :string(255)      default("")
#  phone             :string(255)      default("")
#  address1          :string(255)      default("")
#  address2          :string(255)      default("")
#  address_city      :string(255)      default("")
#  address_state     :string(255)      default("")
#  address_zip       :string(255)      default("")
#  title             :string(255)      default("")
#  pay_hourly        :decimal(8, 2)    default(0.0)
#  pay_daily         :decimal(8, 2)    default(0.0)
#  hire_date         :date
#  term_date         :date
#  fed_filing_status :string(255)      default("")
#  ca_filing_status  :string(255)      default("")
#  fed_allowances    :integer          default(0)
#  ca_allowances     :integer          default(0)
#  dob               :date
#  gender            :string(255)      default("")
#  active            :boolean          default(TRUE)
#  notes             :text             default("")
#  created_at        :datetime
#  updated_at        :datetime
#

class Employee < ActiveRecord::Base

  has_paper_trail

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

  ## VALIDATIONS

  validates :first_name, :last_name, presence: { message: 'required.' },
            length: { maximum: 25, minimum: 2, message: 'must be between 2 and 25 characters.' }

  validates :email,
            format: { with: VALID_EMAIL_REGEX }

  validates :phone, presence: { message: 'required.' },
            format: { with: PHONE_REGEX, message: 'must be 10 digits' }

  validates :address1, :address_city, :fed_filing_status, :ca_filing_status, :hire_date, :dob, :title,
            presence: { message: 'required.' }

  validates :term_date,
            date: { after: :hire_date },
            allow_blank: true

  validates :address_state, presence: { message: 'required.' },
            format: { with: STATE_REGEX, message: 'must be two upper-case letters.' }

  validates :address_zip, presence: { message: 'required.' },
            length: { is: 5 },
            numericality: { message: 'must be 5 digits.' }

  validates :gender, presence: { message: 'required.' },
            format: { with: GENDER_REGEX, message: 'must be either M for F.' }

  validates :pay_hourly, :pay_daily,
            numericality: { message: 'must be a number.' },
            allow_blank: true

  validate :pay_validator

  #validate :min_wage_validator

  validates :fed_allowances, :ca_allowances,  presence: { message: 'required.' },
            length: { is: 1 },
            numericality: { message: 'must be a single digit.' }


  ## WRITERS
  def email=(email)
    write_attribute(:email, email.downcase)
  end

  def phone=(phone)
    write_attribute(:phone, clean_phone(phone))
  end


  ## METHODS
  def self.active
    Employee.where(active: true)
  end

  def self.field_managers
    Employee.where(title: 'field_manager')
  end

  def fundraising_shifts
    self.shifts.select { |s| s.fundraising_shift }
  end

  def shifts_this_week
    self.shifts.where(date: (Date.today.beginning_of_week..Date.today))
  end

  def fundraising_shifts_this_week
    self.shifts_this_week.select { |s| s.fundraising_shift }
  end

  def donations_this_week
    self.donations.select do |d|
        (Date.today.beginning_of_week..Date.today).include?(d.shift.date)
    end
  end

  def successful_donations
    self.donations.select { |d| d.captured }
  end

  def successful_donations_this_week
    self.successful_donations.select do |d|
      (Date.today.beginning_of_week..Date.today).include?(d.shift.date)
    end
  end

  def fundraising_total
    self.successful_donations.sum(&:total_value)
  end


  def fundraising_total_this_week
    self.successful_donations_this_week.sum(&:total_value)
  end

  def fundraising_average
    if self.fundraising_shifts.any?
      self.fundraising_total / self.fundraising_shifts.count
    else
      0
    end

  end

  def fundraising_average_this_week
    if self.fundraising_shifts_this_week.any?
      self.fundraising_total_this_week / self.fundraising_shifts_this_week.count
    else
      0
    end

  end



  private
    def pay_validator
      if ( pay_hourly > 0 && pay_daily > 0 ) || ( pay_hourly == 0 && pay_daily == 0 )
        errors.add(:pay_hourly, 'Specify an hourly or a daily rate, but not both.')
        errors.add(:pay_daily, 'Specify an hourly or a daily rate, but not both.')
      end
    end

    def min_wage_validator
      if pay_hourly < Staffnet2::Application.config.minimum_wage
        errors.add(:pay_hourly, 'Hourly pay must be greater than ' + Staffnet2::Application.config.minimum_wage.to_s )
      end
    end
end
