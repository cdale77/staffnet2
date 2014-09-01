FactoryGirl.define do
  factory :payment_profile do
    cim_payment_profile_id    '44432111'
    payment_profile_type      'cash'
    cc_last_4                 '1234'
    cc_type                   'visa'
    cc_month                  '10'
    cc_year                   '2017'
  end
end