# == Schema Information
#
# Table name: employees
#
#  id                :integer          not null, primary key
#  user_id           :integer
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

  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods
  include Cleaning

  ## RELATIONSHIPS
  belongs_to :user
  has_many :shifts, dependent: :destroy

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
