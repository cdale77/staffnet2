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
    city                Faker::Address.city
    state               Faker::Address.state_abbr
    zip                 '12345'
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
    shift_type      ['street', 'door', 'office', 'phone'].sample
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
    city            Faker::Address.city
    state           Faker::Address.state_abbr
    zip             '94104'
    contact_name    Faker::Name.name
    contact_phone   '5105551234'
    contact_email   Faker::Internet.email
    uri             Faker::Internet.url
    notes           Faker::Lorem.sentence
  end

  factory :project do
    name            'Test project'
    start_date      Date.today - 20.days
    end_date        Date.yesterday
    desc            Faker::Lorem.sentence
    notes           Faker::Lorem.sentence
    client
  end

end
