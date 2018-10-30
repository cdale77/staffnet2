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
#  paycheck_id               :integer
#  site                      :string(255)      default("")
#

class Shift < ActiveRecord::Base

  has_paper_trail

  default_scope { order(date: :desc) }

  ## HSTORE
  store_accessor :products, :phones, :emails, :signatures, :contacts

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :employee, touch: true
  delegate :user, to: :employee
  belongs_to :shift_type
  has_many :donations
  has_many :payments, through: :donations
  belongs_to :paycheck

  ## METHOD DELEGATIONS
  delegate :name, to: :shift_type, prefix: true
  delegate :fundraising_shift, to: :shift_type
  delegate :quota_shift, to: :shift_type
  delegate :workers_comp_type, to: :shift_type

  ## VALIDATIONS
  validates :date,
            presence: { message: "required." }

  validates :break_time,
            numericality: { greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 120,
                            message: "must be less than 121 minutes" },
            allow_blank: true

  validates :travel_reimb,
            numericality: { greater_than_or_equal_to: 0,
                            message: "must be a positive number"  },
            presence: { message: "can't be blank, can be zero (0)" }

  validates :time_in, :time_out,
            presence: { message: "required" }

  validate :shift_time_validator
  validate :reported_yes_validator
  validate :reported_raised_validator


  ## INSTANCE METHODS
  def last_three_weeks
    self.where('created_at > ?', 3.weeks.ago)
  end

  def field_manager
    if self.field_manager_employee_id.present?
      Employee.find(self.field_manager_employee_id)
    end
  end

  def short_version
    "#{self.date.strftime("%Y/%m/%d")}-#{self.employee.full_name} (#{self.shift_type.name.chr.capitalize})"
  end

  def net_time
    self.break_time ||= 0
    self.time_in ||= 0
    self.time_out ||= 0
    ((self.time_out - self.time_in)/3600) - ((self.break_time.to_f)/60.to_f)
  end

  def reported_monthly_value
    #reported_monthly_cc_amt * self.shift_type.monthly_cc_multiplier
    reported_monthly_cc_amt() * 7
  end

  def captured_donations
    self.donations.select { |d| d.captured }
  end

  def reported_quarterly_value
    #reported_quarterly_cc_amt * self.shift_type.quarterly_cc_multiplier
    reported_quarterly_cc_amt() * 3
  end

  def total_deposit
    self.captured_donations.sum(&:amount)
  end

  def gross_fundraising_credit
    self.captured_donations.sum(&:total_value)
  end

  private

    ## CUSTOM VALIDATORS

    def reported_yes_validator
      unless (reported_cash_qty + reported_check_qty + reported_one_time_cc_qty + reported_monthly_cc_qty + reported_quarterly_cc_qty) == reported_total_yes
        errors.add(:reported_raised, "Raised amount must equal itemized amounts.")
      end
    end

    def reported_raised_validator
      unless (reported_cash_amt + reported_check_amt + reported_one_time_cc_amt + reported_monthly_value + reported_quarterly_value ) == reported_raised
        errors.add(:reported_raised, "Raised amount must equal itemized amounts.")
      end
    end

    def shift_time_validator
      errors.add(:time_out, "You cannot have zero or negative hours.") unless (2..24).include?(net_time)
    end

end
