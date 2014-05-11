# == Schema Information
#
# Table name: shifts
#
#  id                        :integer          not null, primary key
#  employee_id               :integer
#  field_manager_employee_id :integer
#  shift_type_id             :integer
#  legacy_id                 :string(255)      default("")
#  date                      :date
#  time_in                   :time
#  time_out                  :time
#  break_time                :integer          default(0)
#  notes                     :text             default("")
#  travel_reimb              :decimal(8, 2)    default(0.0)
#  cv_shift                  :boolean          default(FALSE)
#  quota_shift               :boolean          default(FALSE)
#  products                  :hstore           default({})
#  reported_raised           :decimal(8, 2)    default(0.0)
#  reported_total_yes        :integer          default(0)
#  reported_cash_qty         :integer          default(0)
#  reported_cash_amt         :decimal(8, 2)    default(0.0)
#  reported_check_qty        :integer          default(0)
#  reported_check_amt        :decimal(8, 2)    default(0.0)
#  reported_one_time_cc_qty  :integer          default(0)
#  reported_one_time_cc_amt  :decimal(8, 2)    default(0.0)
#  reported_monthly_cc_qty   :integer          default(0)
#  reported_monthly_cc_amt   :decimal(8, 2)    default(0.0)
#  reported_quarterly_cc_amt :integer          default(0)
#  reported_quarterly_cc_qty :decimal(8, 2)    default(0.0)
#  created_at                :datetime
#  updated_at                :datetime
#

class Shift < ActiveRecord::Base

  default_scope { order(date: :desc) }

  ## HSTORE
  store_accessor :products, :phones, :emails, :signatures, :contacts

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  #belongs_to :user
  belongs_to :employee
  delegate :user, to: :employee
  belongs_to :shift_type
  has_many :donations
  has_many :payments, through: :donations
  #has_many :tasks, dependent: :destroy

  ## VALIDATIONS
  validates :date,
            presence: { message: 'required.' }

  validates :break_time,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120, message: 'must be less than 121 minutes.' },
            allow_blank: true

  validates :travel_reimb,
            numericality: { greater_than_or_equal_to: 0, message: 'must be a positive number.'  },
            allow_blank: true

  validates :time_in, :time_out,
            presence: { message: 'required' }

  validate :shift_time_validator
  validate :reported_yes_validator
  validate :reported_raised_validator


  ## INSTANCE METHODS
  def field_manager
    Employee.find(self.field_manager_employee_id) if self.field_manager_employee_id.present?
  end

  def short_version
    "#{self.date.strftime('%Y/%m/%d')}-#{self.employee.full_name}"
  end

  def net_time
    self.break_time ||= 0
    self.time_in ||= 0
    self.time_out ||= 0
    ((self.time_out - self.time_in)/3600) - ((self.break_time.to_f)/60.to_f)
  end

  def reported_monthly_value
    reported_monthly_cc_amt * shift_type.monthly_cc_multiplier
  end

  def reported_quarterly_value
    reported_quarterly_cc_amt * shift_type.quarterly_cc_multiplier
  end



  private

    ## CUSTOM VALIDATORS

    def reported_yes_validator
      unless (reported_cash_qty + reported_check_qty + reported_one_time_cc_qty + reported_monthly_cc_qty + reported_quarterly_cc_qty) == reported_total_yes
        errors.add(:reported_raised, 'Raised amount must equal itemized amounts.')
      end
    end

    def reported_raised_validator
      unless (reported_cash_amt + reported_check_amt + reported_one_time_cc_amt + reported_monthly_value + reported_quarterly_value ) == reported_raised
        errors.add(:reported_raised, 'Raised amount must equal itemized amounts.')
      end
    end

    def shift_time_validator
      errors.add(:time_out, 'You cannot have zero or negative hours.') unless (2..24).include?(net_time)
    end

end
