# == Schema Information
#
# Table name: paychecks
#
#  id                       :integer          not null, primary key
#  payroll_id               :integer
#  employee_id              :integer
#  check_date               :date
#  cv_shift_quantity        :integer          default(0)
#  quota_shift_quantity     :integer          default(0)
#  office_shift_quantity    :integer          default(0)
#  sick_shift_quantity      :integer          default(0)
#  vacation_shift_quantity  :integer          default(0)
#  holiday_shift_quantity   :integer          default(0)
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
end
