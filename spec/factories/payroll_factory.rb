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