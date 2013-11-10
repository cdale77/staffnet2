FactoryGirl.define do

  factory :user do
    email                 ('a'..'z').to_a.shuffle[0,6].join + 'user@example.com'
    role                  ''
    password              'foobar7878'
    password_confirmation 'foobar7878'

    factory :super_admin do
      email             ('a'..'z').to_a.shuffle[0,6].join + 'user@example.com'
      role              'super_admin'
    end

    factory :admin do
      email             ('a'..'z').to_a.shuffle[0,6].join + 'user@example.com'
      role              'admin'
    end

    factory :manager do
      email             ('a'..'z').to_a.shuffle[0,6].join + 'user@example.com'
      role              'manager'
    end

    factory :staff do
      email             ('a'..'z').to_a.shuffle[0,6].join + 'user@example.com'
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

end
