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
                                address_city:       Faker::Address.city,
                                address_state:      'CA',
                                address_zip:        '94'+ (1..3).to_a.shuffle.join.to_s,
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
    names = ['door', 'street', 'phone', 'office', 'vacation', 'holiday', 'sick' ]
    names.each do |name|
      new_type = ShiftType.new(name: name)
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
                            address_city:   Faker::Address.city,
                            address_state:  'CA',
                            address_zip:    '94'+ (1..3).to_a.shuffle.join.to_s,
                            contact_name:   Faker::Name.name,
                            contact_phone:  (0..9).to_a.shuffle.join.to_s,
                            contact_email:  Faker::Internet.email,
                            uri:            Faker::Internet.url )
      client.save
    end

    # supporter types
    ['Supporter-test', 'Donor-test', 'Media-test', 'Official-test', 'Staff-test', 'Volunteer-test'].each do |type|
      SupporterType.create(name: type)
    end

    SupporterType.all.each do |supporter_type|
      3.times do
        supporter =   Supporter.new(  first_name:     Faker::Name.first_name,
                                      last_name:      Faker::Name.last_name,
                                      address1:       Faker::Address.street_address,
                                      address_city:   Faker::Address.city,
                                      address_state:  'CA',
                                      address_zip:    '94709',
                                      email_1:        Faker::Internet.email,
                                      phone_mobile:   '5108493849',
                                      phone_alt:      '4503403123',

        )
        supporter.supporter_type_id = supporter_type.id
        supporter.save
      end

      # donations
      Supporter.all.each do |supporter|
        2.times do
          donation = supporter.donations.build( date: Date.today,
                                                source: 'mail',
                                                campaign: 'energy',
                                                donation_type: %W[credit check cash].sample,
                                                amount: [5, 10, 15, 20, 50, 100].sample )
          donation.shift_id = Shift.all.sample.id
          donation.save
        end
      end

      # payments
      Donation.all.each do |donation|
        payment = donation.payments.build(  deposited_at: Date.today,
                                            amount: donation.amount,
                                            payment_type: donation.donation_type)
        payment.save
      end

      # payment_profiles
=begin
      Supporter.all.each do |supporter|
        profile = supporter.payment_profiles.build( payment_profile_type: 'credit',
                                                    details: {  cc_type:    'visa',
                                                                cc_last_4:  '1111',
                                                                cc_month:   '10',
                                                                cc_year:    '2017' })
        profile.save
      end
=end
    end

=begin

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

    # task types
    8.times do |n|
      task_type = TaskType.new( name: Faker::Lorem.word, desc: Faker::Lorem.sentence )
      task_type.save
    end

    # tasks
    Shift.all.each do |shift|
      7.times do |n|
        task = shift.tasks.build(       name:       Faker::Lorem.word,
                                        hours:      [1, 2, 3, 2.25, 4, 3.75, 1.5].sample,
                                        desc:       Faker::Lorem.word,
                                        notes:      Faker::Lorem.sentence )

        # assign the task to a random project and task_type
        task.project_id = (1..Project.count).to_a.sort{ rand() - 0.5}[0]
        task.task_type_id = (1..TaskType.count).to_a.sort{ rand() - 0.5}[0]
        task.save
      end
    end
=end

  end
end