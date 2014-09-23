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
#  break_time                :integer          default("0")
#  notes                     :text             default("")
#  travel_reimb              :decimal(8, 2)    default("0.0")
#  products                  :hstore           default("")
#  reported_raised           :decimal(8, 2)    default("0.0")
#  reported_total_yes        :integer          default("0")
#  reported_cash_qty         :integer          default("0")
#  reported_cash_amt         :decimal(8, 2)    default("0.0")
#  reported_check_qty        :integer          default("0")
#  reported_check_amt        :decimal(8, 2)    default("0.0")
#  reported_one_time_cc_qty  :integer          default("0")
#  reported_one_time_cc_amt  :decimal(8, 2)    default("0.0")
#  reported_monthly_cc_qty   :integer          default("0")
#  reported_monthly_cc_amt   :decimal(8, 2)    default("0.0")
#  reported_quarterly_cc_amt :integer          default("0")
#  reported_quarterly_cc_qty :decimal(8, 2)    default("0.0")
#  created_at                :datetime
#  updated_at                :datetime
#  paycheck_id               :integer
#  site                      :string(255)      default("")
#

FactoryGirl.define do
  factory :shift do
    date                        Date.today
    time_in                     Time.now - 5.hours
    time_out                    Time.now
    break_time                  30
    travel_reimb                12.5
    notes                       'Great shift'
    reported_raised             335
    reported_total_yes          7
    reported_cash_qty           2
    reported_cash_amt           25
    reported_check_qty          1
    reported_check_amt          100
    reported_one_time_cc_qty    1
    reported_one_time_cc_amt    50
    reported_monthly_cc_qty     1
    reported_monthly_cc_amt     10
    reported_quarterly_cc_qty   2
    reported_quarterly_cc_amt   30
    site                        "Whole Foods"
    employee
    shift_type
    paycheck
  end

end
