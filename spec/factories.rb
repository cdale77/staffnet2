FactoryGirl.define do

  factory :user do
    first_name            'Brad'
    last_name             'Johnson'
    sequence(:email)       {|n| "user#{n}@example.com" }
    role                   ''
    password              'foobar7878'
    password_confirmation 'foobar7878'

    factory :super_admin do
      role              'super_admin'
    end

    factory :admin do
      role              'admin'
    end

    factory :manager do
      role              'manager'
    end

    factory :staff do
      role              'staff'
    end
  end

  factory :employee do
    first_name          'Numberone'
    last_name           'Employee'
    phone               '5105551234'
    email               'employee@example.com'
    address1            '1234 Main St.'
    address2            'Apt 318'
    city                'Cleveland'
    state               'OH'
    zip                 '12345'
    title               'Organizer'
    pay_hourly          12.00
    fed_filing_status   'single'
    ca_filing_status    'single'
    fed_allowances      2
    ca_allowances       2
    dob                 Date.today
    hire_date           Date.today
    gender              'f'
    active              true
  end
end
