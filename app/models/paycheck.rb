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
    vactation_shifts = total_shifts.select { |s| s.shift_type_name == "vacation" }
    office_shifts = total_shifts.select { |s| s.shift_type_name == "holiday" }

    self.shift_quantity = total_shifts.count
    self.cv_shift_quantity = cv_shifts.count
    self.quota_shift_quantity = quota_shifts.count
    self.office_shift_quantity = office_shifts.count

  end



end
