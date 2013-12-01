namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    #create user with each role user for testing
    ['super_admin', 'admin', 'manager', 'staff' ''].each do |role|
      user = User.new(  email:                  "#{role}-example@example.com",
                        role:                   role,
                        password:               'foobar7878',
                        password_confirmation:  'foobar7878')
      user.save
    end

    # create employees
    User.all.each do |user|
      employee = user.build_employee(  first_name:  Faker::Name.first_name,
                                last_name:          Faker::Name.last_name,
                                email:              user.email,
                                phone:              (0..9).to_a.shuffle.join.to_s,
                                address1:           Faker::Address.street_address,
                                address2:           Faker::Address.secondary_address,
                                city:               Faker::Address.city,
                                state:              'CA',
                                zip:                '94'+ (1..3).to_a.shuffle.join.to_s,
                                title:              ['caller', 'canvasser','director'].sample,
                                pay_hourly:         [11.50, 12.25, 12, 13.50].sample,
                                hire_date:          Date.today,
                                fed_filing_status:  ['single', 'married'].sample,
                                ca_filing_status:   ['single', 'married'].sample,
                                fed_allowances:     [0, 1, 2, 3].sample,
                                ca_allowances:      [0, 1, 2, 3].sample,
                                dob:                Date.today - 20.years,
                                gender:             ['m', 'f'].sample,
                                active:             true )
      employee.save
    end

    # shift_types
    shift_types = ['door', 'street', 'phone', 'office', 'vacation', 'holiday', 'sick' ]
    shift_types.each do |shift_type|
      new_type = ShiftType.new(shift_type: shift_type)
      new_type.save
    end

    # shifts
    Employee.all.each do |employee|
      15.times do |n|
        #shift_type = ShiftType.create!(shift_type: shift_types.sample)
        shift_type = ShiftType.order("RANDOM()").first
        s = employee.shifts.build(  date:           Date.today,
                                    #time_in:        Time.now - 5.hours,
                                    #time_out:       Time.now,
                                    time_in:        '9:00',
                                    time_out:       '17:00',
                                    break_time:     30,
                                    travel_reimb:   12.50,
                                    shift_type_id:  shift_type.id,
                                    notes:          'test shift' + n.to_s  )
        s.save
      end
    end

    # clients
    5.times do |n|
      client = Client.new(  name:           Faker::Company.name,
                            address1:       Faker::Address.street_address,
                            address2:       Faker::Address.secondary_address,
                            city:           Faker::Address.city,
                            state:          'CA',
                            zip:            '94'+ (1..3).to_a.shuffle.join.to_s,
                            contact_name:   Faker::Name.name,
                            contact_phone:  (0..9).to_a.shuffle.join.to_s,
                            contact_email:  Faker::Internet.email,
                            uri:            Faker::Internet.url )
      client.save
    end

    # projects
    Client.all.each do |client|
      4.times do |n|
        project = client.projects.build(  name:       Faker::Company.catch_phrase,
                                          start_date: Date.today - 23.days,
                                          end_date:   Date.yesterday,
                                          desc:       Faker::Lorem.sentence,
                                          notes:      Faker::Lorem.sentence )
        project.save

      end
    end

  end
end