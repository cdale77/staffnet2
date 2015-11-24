namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    #create user with each role user for testing
    ['super_admin', 'admin', 'manager', 'staff', ''].each do |role|
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
                                title:              ['caller', 'field_manager','director'].sample,
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
    names = ["door", "street", "phone", "vacation" ]
    names.each do |name|
      new_type = ShiftType.new(name: name)
      unless name == "vacation"
        new_type.fundraising_shift = true
      end
      if name == "vacation"
        new_type.quota_shift = false
      end
      new_type.monthly_cc_multiplier = 7
      new_type.quarterly_cc_multiplier = 3
      new_type.save
    end

    # shifts
    Employee.all.each do |employee|
      15.times do |n|
        #shift_type = ShiftType.create!(shift_type: shift_types.sample)
        shift_type = ShiftType.order("RANDOM()").first
        s = employee.shifts.build(  date:           Date.today,
                                    time_in:        '9:00',
                                    time_out:       '17:00',
                                    break_time:     30,
                                    travel_reimb:   12.50,
                                    shift_type_id:  shift_type.id,
                                    notes:          'test shift' + n.to_s  )
        s.save
      end
    end


    # supporter types
    ['supporter', 'donor', 'media', 'official'].each do |type|
      SupporterType.create(name: type)
    end

    SupporterType.all.each do |supporter_type|
      sendy_list = supporter_type.sendy_lists.build
      sendy_list.name = supporter_type.name.pluralize
      sendy_list.sendy_list_identifier = '23r23'
      sendy_list.save
    end

    SupporterType.all.each do |supporter_type|
      10.times do
        supporter =   Supporter.new(  first_name:     Faker::Name.first_name,
                                      last_name:      Faker::Name.last_name,
                                      address1:       Faker::Address.street_address,
                                      address_city:   Faker::Address.city,
                                      address_state:  'CA',
                                      address_zip:    '94709',
                                      email_1:        Faker::Internet.email,
                                      phone_mobile:   '5108493849',
                                      phone_alt:      '4503403123',
                                      source:         %W[door street phone web].sample

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
        donation.payments.create!(  deposited_at: Date.today,
                                    amount: donation.amount,
                                    payment_type: donation.donation_type,
                                    captured: true,
                                    processed: true,
                                    receipt_sent_at: Time.now)

      end
    end
  end
end
