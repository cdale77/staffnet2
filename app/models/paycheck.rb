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
#  temp_buffer              :decimal(8, 2)    default("0.0")
#  bonus_credit             :decimal(8, 2)    default("0.0")
#  total_salary             :decimal(8, 2)    default("0.0")
#

class Paycheck < ActiveRecord::Base

  has_paper_trail

  default_scope { order(check_date: :desc) }

  ## RELATIONSHIPS
  belongs_to :employee, touch: true
  belongs_to :payroll, touch: true
  has_many :shifts

  ## DELEGATIONS
  delegate :user, to: :employee


  def inside_shift_count
    self.shifts.select { |s| s.workers_comp_type == "inside"}.count
  end

  def outside_shift_count
    self.shifts.select { |s| s.workers_comp_type == "outside"}.count
  end

end
