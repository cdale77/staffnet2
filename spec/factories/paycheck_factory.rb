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
#

FactoryGirl.define do
  factory :paycheck do

    check_date                Date.today
    shift_quantity            10.0
    cv_shift_quantity         8
    office_shift_quantity     2
    total_deposit             2345.0
    old_buffer                500
    new_buffer                500
    temp_buffer               780
    bonus                     450
    total_pay                 2000
    travel_reimb              12.50
    notes                     "some notes"
    gross_fundraising_credit  3000
  end
end
