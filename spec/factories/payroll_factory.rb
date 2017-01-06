# == Schema Information
#
# Table name: payrolls
#
#  id                           :integer          not null, primary key
#  start_date                   :date
#  end_date                     :date
#  check_quantity               :integer          default(0)
#  shift_quantity               :decimal(8, 2)    default(0.0)
#  cv_shift_quantity            :decimal(8, 2)    default(0.0)
#  quota_shift_quantity         :decimal(8, 2)    default(0.0)
#  office_shift_quantity        :decimal(8, 2)    default(0.0)
#  sick_shift_quantity          :decimal(8, 2)    default(0.0)
#  holiday_shift_quantity       :decimal(8, 2)    default(0.0)
#  total_deposit                :decimal(8, 2)    default(0.0)
#  created_at                   :datetime
#  updated_at                   :datetime
#  vacation_shift_quantity      :decimal(8, 2)    default(0.0)
#  notes                        :text             default("")
#  gross_fundraising_credit     :decimal(8, 2)    default(0.0)
#  net_fundraising_credit       :decimal(8, 2)    default(0.0)
#  paycheck_report_file_name    :string
#  paycheck_report_content_type :string
#  paycheck_report_file_size    :integer
#  paycheck_report_updated_at   :datetime
#  shift_report_file_name       :string
#  shift_report_content_type    :string
#  shift_report_file_size       :integer
#  shift_report_updated_at      :datetime
#

FactoryGirl.define do
  factory :payroll do
    start_date  ( Date.today.at_beginning_of_week - 15.days )
    end_date    ( Date.today.at_beginning_of_week - 2.days )
    check_quantity            8
    shift_quantity            80
    cv_shift_quantity         74
    quota_shift_quantity      80
    office_shift_quantity     16
    sick_shift_quantity       0
    vacation_shift_quantity   0
    holiday_shift_quantity    0
    total_deposit             9876
    gross_fundraising_credit  10764
  end
end
