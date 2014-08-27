# == Schema Information
#
# Table name: paychecks
#
#  id                       :integer          not null, primary key
#  payroll_id               :integer
#  employee_id              :integer
#  check_date               :date
#  shift_quantity           :decimal(8, 2)    default(0.0)
#  cv_shift_quantity        :decimal(8, 2)    default(0.0)
#  quota_shift_quantity     :decimal(8, 2)    default(0.0)
#  office_shift_quantity    :decimal(8, 2)    default(0.0)
#  sick_shift_quantity      :decimal(8, 2)    default(0.0)
#  vacation_shift_quantity  :decimal(8, 2)    default(0.0)
#  holiday_shift_quantity   :decimal(8, 2)    default(0.0)
#  total_deposit            :decimal(8, 2)    default(0.0)
#  total_fundraising_credit :decimal(8, 2)    default(0.0)
#  old_buffer               :decimal(8, 2)    default(0.0)
#  new_buffer               :decimal(8, 2)    default(0.0)
#  total_pay                :decimal(8, 2)    default(0.0)
#  bonus                    :decimal(8, 2)    default(0.0)
#  travel_reimb             :decimal(8, 2)    default(0.0)
#  created_at               :datetime
#  updated_at               :datetime
#

class Paycheck < ActiveRecord::Base

  has_paper_trail

  default_scope { order(check_date: :desc) }

  ## RELATIONSHIPS
  belongs_to :employee
  belongs_to :payroll
  has_many :shifts

  def calculate_values
    total_shifts = self.shifts
    cv_shifts = total_shifts.select { |s| s.fundraising_shift }
    quota_shifts = total_shifts.select { |s| s.quota_shift }
    office_shifts = total_shifts.select { |s| s.shift_type_name == "office" }
    sick_shifts = total_shifts.select { |s| s.shift_type_name == "sick" }
    vacation_shifts = total_shifts.select { |s| s.shift_type_name == "vacation" }
    holiday_shifts = total_shifts.select { |s| s.shift_type_name == "holiday" }

    total_deposit = total_shifts.map(&:total_deposit).inject(0, &:+)
    total_fundraising_credit = total_shifts.map(&:gross_fundraising_credit).inject(0, &:+)

    total_pay = total_shifts.count * self.employee.pay_daily
    travel_reimb = total_shifts.map(&:travel_reimb).inject(0, &:+)

    self.shift_quantity = total_shifts.count
    self.cv_shift_quantity = cv_shifts.count
    self.quota_shift_quantity = quota_shifts.count
    self.office_shift_quantity = office_shifts.count
    self.sick_shift_quantity = sick_shifts.count
    self.vacation_shift_quantity = vacation_shifts.count
    self.holiday_shift_quantity = holiday_shifts.count
    self.total_deposit = total_deposit
    self.total_fundraising_credit = total_fundraising_credit
    self.total_pay = total_pay
    self.travel_reimb = travel_reimb
  end



end
