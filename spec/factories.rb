require 'Faker'

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    role                  ''
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
    title               'Organizer'
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
    name      ['street', 'door', 'office', 'phone'].sample
  end

  factory :shift do
    date                Date.today
    time_in             Time.now - 5.hours
    time_out            Time.now
    break_time          30
    travel_reimb        12.5
    notes               'Great shift'
    employee
    shift_type
  end

  factory :client do
    name            Faker::Company.name
    address1        Faker::Address.street_address
    address2        Faker::Address.secondary_address
    address_city    Faker::Address.city
    address_state   Faker::Address.state_abbr
    address_zip     '94104'
    contact_name    Faker::Name.name
    contact_phone   '5105551234'
    contact_email   Faker::Internet.email
    uri             Faker::Internet.url
    notes           Faker::Lorem.sentence
  end

  factory :supporter_type do
    name        ['Supporter-test', 'Donor-test', 'Media-test', 'Official-test', 'Staff-test', 'Volunteer-test'].sample
  end

  factory :supporter do
    #mailchimp_leid        '44552323'
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
    donation_type     'Credit Card'
    source            'Mail'
    campaign          'Energy'
    amount            10.00
    supporter
  end

  factory :payment do
    deposited_at          Time.now
    payment_type          'Credit Card'
    captured              true
    amount                10.00
    cc_last_4             '1234'
    cc_type               'visa'
    cc_month              '01'
    cc_year               '2014'
    cim_transaction_id    '1122223333'
    donation
  end

=begin
  factory :project do
    name            Faker::Lorem.word + ' ' + Faker::Lorem.word
    start_date      Date.today - 20.days
    end_date        Date.yesterday
    desc            Faker::Lorem.sentence
    notes           Faker::Lorem.sentence
    client
  end

  factory :task_type do
    name          Faker::Lorem.word
    desc          Faker::Lorem.sentence
  end

  factory :task do
    name          Faker::Lorem.word + ' ' + Faker::Lorem.word
    hours          2.00
    desc          Faker::Lorem.word + ' ' + Faker::Lorem.word
    notes         Faker::Lorem.sentence
    shift
    project
    task_type
  end
=end



end
