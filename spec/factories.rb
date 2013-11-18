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
    first_name          'User'
    last_name           'Employee'
    phone               '5105551234'
    email               ('a'..'z').to_a.shuffle[0,10].join + 'employee@example.com'
    address1            '1234 Main St.'
    address2            'Apt 318'
    city                'Cleveland'
    state               'OH'
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

=begin
  factory :staff_employee do
    first_name          'Staffer'
    last_name           'Employee'
    phone               '5105551234'
    email               ('a'..'z').to_a.shuffle[0,10].join + 'staff_employee@example.com'
    address1            '1234 Main St.'
    address2            'Apt 318'
    city                'Cleveland'
    state               'OH'
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

  factory :super_admin_employee do
    first_name          'SuperAdmin'
    last_name           'Employee'
    phone               '5105551234'
    email               ('a'..'z').to_a.shuffle[0,10].join + 'super_admin_employee@example.com'
    address1            '1234 Main St.'
    address2            'Apt 318'
    city                'Cleveland'
    state               'OH'
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
    super_admin
  end
=end

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
    name            'Test client'
    address1        '123 Mission St'
    address2        'Ste. 350'
    city            'San Francisco'
    state           'CA'
    zip             '94104'
    contact_name    'Ed Lee'
    contact_phone   '4158634511'
    contact_email   'ed@example.com'
    uri             'http://www.example.com'
    notes           'Some notes here.'
  end

end
