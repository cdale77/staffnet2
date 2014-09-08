# == Schema Information
#
# Table name: paychecks
#
#  id                       :integer          not null, primary key
#  payroll_id               :integer
#  employee_id              :integer
#  check_date               :date
#  shift_quantity           :decimal(8, 2)    default("0.0")
#  cv_shift_quantity        :decimal(8, 2)    default("0.0")
#  quota_shift_quantity     :decimal(8, 2)    default("0.0")
#  office_shift_quantity    :decimal(8, 2)    default("0.0")
#  sick_shift_quantity      :decimal(8, 2)    default("0.0")
#  vacation_shift_quantity  :decimal(8, 2)    default("0.0")
#  holiday_shift_quantity   :decimal(8, 2)    default("0.0")
#  total_deposit            :decimal(8, 2)    default("0.0")
#  old_buffer               :decimal(8, 2)    default("0.0")
#  new_buffer               :decimal(8, 2)    default("0.0")
#  total_pay                :decimal(8, 2)    default("0.0")
#  bonus                    :decimal(8, 2)    default("0.0")
#  travel_reimb             :decimal(8, 2)    default("0.0")
#  created_at               :datetime
#  updated_at               :datetime
#  notes                    :text             default("")
#  gross_fundraising_credit :decimal(8, 2)    default("0.0")
#  credits                  :decimal(8, 2)    default("0.0")
#  docks                    :decimal(8, 2)    default("0.0")
#  total_quota              :decimal(8, 2)    default("0.0")
#  net_fundraising_credit   :decimal(8, 2)    default("0.0")
#  over_quota               :decimal(8, 2)    default("0.0")
#

class Paycheck < ActiveRecord::Base

  has_paper_trail

  default_scope { order(check_date: :desc) }

  ## RELATIONSHIPS
  belongs_to :employee
  belongs_to :payroll
  has_many :shifts

  def inside_shift_count
    self.shifts.select { |s| s.workers_comp_type == "inside"}.count
  end

  def outside_shift_count
    self.shifts.select { |s| s.workers_comp_type == "outside"}.count
  end

  def calculate_values

    values = {
        shift_quantity:           self.calculate_total_shifts,
        cv_shift_quantity:        self.calculate_cv_shifts,
        quota_shift_quantity:     self.calculate_quota_shifts,
        office_shift_quantity:    self.calculate_shifts_by_type("office"),
        sick_shift_quantity:      self.calculate_shifts_by_type("sick"),
        vacation_shift_quantity:  self.calculate_shifts_by_type("vacation"),
        holiday_shift_quantity:   self.calculate_shifts_by_type("holiday"),
        total_deposit:            self.calculate_total_deposit,
        gross_fundraising_credit: self.calculate_fundraising_credit,
        total_pay:                self.calculate_total_pay,
        travel_reimb:             self.calculate_travel_reimb
    }

    update_attributes!(values)

  end

  # methods for calculating paycheck numbers. Named to not conflict with
  # attribute names
  def calculate_travel_reimb
    self.shifts.map(&:travel_reimb).inject(0, &:+)
  end

  def calculate_total_pay
    calculate_total_shifts * self.employee.pay_daily
  end

  def calculate_fundraising_credit
    self.shifts.map(&:gross_fundraising_credit).inject(0, &:+)
  end

  def calculate_total_deposit
    self.shifts.map(&:total_deposit).inject(0, &:+)
  end

  def calculate_shifts_by_type(type)
    self.shifts.select { |s| s.shift_type_name == type.to_s }.count
  end

  def calculate_quota_shifts
    self.shifts.select { |s| s.quota_shift }.count
  end

  def calculate_cv_shifts
    self.shifts.select { |s| s.fundraising_shift }.count
  end

  def calculate_total_shifts
    self.shifts.count
  end
end
