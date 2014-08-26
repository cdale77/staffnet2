require 'Faker'

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    role                  ''
    confirmation_sent_at  Time.now
    confirmed_at          Time.now
    password              'foobar7878'
    password_confirmation 'foobar7878'

    factory :super_admin do
      email
      role              'super_admin'
    end

    factory :admin do
      email
      role              'admin'
    end

    factory :manager do
      email
      role              'manager'
    end

    factory :staff do
      email
      role              'staff'
    end
  end

  factory :employee do
    first_name          Faker::Name.first_name
    last_name           Faker::Name.last_name
    phone               '5105551234'
    email               ('a'..'z').to_a.shuffle[0,10].join + 'employee@example.com'
    address1            Faker::Address.street_address
    address2            Faker::Address.secondary_address
    address_city        Faker::Address.city
    address_state       Faker::Address.state_abbr
    address_zip         '12345'
    title               'organizer'
    pay_hourly          12
    fed_filing_status   'single'
    ca_filing_status    'single'
    fed_allowances      2
    ca_allowances       2
    dob                 Date.today
    hire_date           Date.today
    gender              'f'
    active              true
    user
  end

  factory :shift_type do
    name                  ['street', 'door', 'office', 'phone'].sample
    monthly_cc_multiplier    7
    quarterly_cc_multiplier  3
  end

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
    employee
    shift_type
  end

  factory :supporter_type do
    name        'supporter'
  end

  factory :sendy_list do
    name      'supporters'
    sendy_list_identifier '23413rq3t985'
  end

  factory :supporter do
    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    address1              Faker::Address.street_address
    address2              Faker::Address.secondary_address
    address_city          Faker::Address.city
    address_state         'CA'
    address_zip           '94523'
    email_1               Faker::Internet.email
    email_2               Faker::Internet.email
    phone_mobile          '5553234322'
    phone_home            '5553232325'
    phone_alt             '5554954933'
    vol_level             2
    employer              Faker::Company.name
    occupation            'Consultant'
    source                Faker::Lorem.word
    notes                 Faker::Lorem.sentence
    supporter_type
  end

  factory :donation do
    date              Date.today
    donation_type     'cash'
    source            'mail'
    campaign          'energy'
    amount            10.00
    supporter
  end

  factory :payment do
    payment_type          'cash'
    captured              true
    amount                10.00
    processed             true
    receipt_sent_at       Time.now
    donation
  end

  factory :payment_profile do
    cim_payment_profile_id    '44432111'
    payment_profile_type      'cash'
    cc_last_4                 '1234'
    cc_type                   'visa'
    cc_month                  '10'
    cc_year                   '2017'
  end

  factory :sendy_update do
    sendy_email     'example@example.com'
    new_sendy_email 'new_example@example.com'
    new_sendy_status  'subscribed'
    action          'subscribe'
    success         true
  end

  factory :supporter_email do
    body          'An email'
    success       true
  end

  factory :tag do
    name "MyString"
  end

  factory :tagging do
    tag nil
    article nil
  end

  factory :deposit_batch do
    date Date.today
    batch_type 'installment'
  end

  factory :payroll do
    start_date                    Date.today - 2.weeks
        end_date                  Date.today
        check_quantity            8
        shift_quantity            80
        cv_shift_quantity         74
        quota_shift_quantity      80
        office_shift_quantity     16
        sick_shift_quantity       0
        vacation_shift_quantity   0
        holiday_shift_quantity    0
        total_deposit             9876
        total_fundraising_credit  10764
  end
end
