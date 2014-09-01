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
  end

end