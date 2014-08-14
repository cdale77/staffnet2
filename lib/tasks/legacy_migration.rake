require 'csv'

namespace :import do

  def save_error_record(record_id, record_name, message)
    MigrationError.create!(record_id: record_id, record_name:
        record_name, message: message)
  end

  def mark_as_migrated(record)
    record.migrated = true
    record.save
  end

  task :prepare => :environment do

    ## Create shift types
    names = ['door', 'street', 'phone', 'office', 'vacation', 'holiday', 'sick' ]
    names.each do |name|
      new_type = ShiftType.create!(name: name)
    end

    supporter_type = SupporterType.create!(name: 'supporter')
    major_donor_type = SupporterType.create!(name: 'major_donor')
    political_type = SupporterType.create!(name: 'political_contact')
    school_board_type = SupporterType.create!(name: 'school_board')
    city_council_type = SupporterType.create!(name: 'city_council')

    puts "What is the Sendy list id for the supporters list?"
    sendy_list_id = STDIN.gets.chomp
    supporter_type.sendy_lists.create!(name: 'supporters', sendy_list_identifier: sendy_list_id )


    puts "What is the Sendy list id for the major_donors list?"
    sendy_list_id = STDIN.gets.chomp
    major_donor_type.sendy_lists.create!(name: 'major_donors', sendy_list_identifier: sendy_list_id)


    puts "What is the Sendy list id for the political_contacts list?"
    sendy_list_id = STDIN.gets.chomp
    political_type.sendy_lists.create!(name: 'political_contacts', sendy_list_identifier: sendy_list_id)

    puts "What is the Sendy list id for the school board list?"
    sendy_list_id = STDIN.gets.chomp
    political_type.sendy_lists.create!(name: 'school_board', sendy_list_identifier: sendy_list_id)

    puts "What is the Sendy list id for the city council list?"
    sendy_list_id = STDIN.gets.chomp
    political_type.sendy_lists.create!(name: 'city_council', sendy_list_identifier: sendy_list_id)

  end

  task :users_and_employees => :environment do
    legacy_users = Migration::User.all
    puts "Migrating #{legacy_users.count.to_s} legacy users. . . "
    legacy_users.each do |legacy_user|
      new_password = SecureRandom.hex(7)
      begin
        new_user = User.new(email: legacy_user.email,
                            password: new_password,
                            password_confirmation: new_password,
                            role: legacy_user.role,
                            created_at: legacy_user.created_at,
                            updated_at: legacy_user.updated_at)
      rescue
        puts "ERROR migrating legacy user #{legacy_user.id.to_s}. Could not create new user."
        save_error_record(legacy_user.id, 'legacy_user', 'Could not instantiate new user object')
        next
      end

      begin
        if new_user.save
          puts "New password for #{new_user.email}: #{new_password}"
          mark_as_migrated(legacy_user)
        else
          puts "Could not save user record for #{new_user.email}"
          save_error_record(new_user.id, 'new_user', 'Could not save new user')
          puts new_user.errors.full_messages
        end
      rescue
        puts "Exception migrating legacy user #{legacy_user.id.to_s}. Could not save user."
        save_error_record(legacy_user.id, 'legacy_user', 'Exception while saving new user record')
        next
      end

      begin
        new_employee = new_user.build_employee( first_name: legacy_user.first_name, last_name: legacy_user.last_name,
                                                email: new_user.email, phone: legacy_user.phone, address1: legacy_user.address1,
                                                address2: legacy_user.address2, address_city: legacy_user.city,
                                                address_zip: legacy_user.zip, address_state: legacy_user.state,
                                                title: legacy_user.rank,
                                                pay_hourly: (legacy_user.pay_hourly ? legacy_user.pay_hourly : 0),
                                                pay_daily: (legacy_user.pay_daily ? legacy_user.pay_daily : 0),
                                                hire_date: legacy_user.hire_date,
                                                term_date: legacy_user.term_date, fed_filing_status: legacy_user.filing_status,
                                                ca_filing_status: legacy_user.filing_status, fed_allowances: legacy_user.w_holding,
                                                ca_allowances: legacy_user.w_holding, dob: legacy_user.dob,
                                                gender: legacy_user.gender, active: legacy_user.active,
                                                created_at: legacy_user.created_at,
                                                updated_at: legacy_user.updated_at,
                                                legacy_id: legacy_user.id.to_s,
                                              )
      rescue
        puts "ERROR creating employee record for #{new_user.email}"
        save_error_record(new_user.id, 'new_user', 'error while building a new employee record')
        next
      end


      if new_employee.save
        puts "Saved new employee record id #{new_employee.id.to_s}"
      else
        puts "ERROR saving employee record for #{new_user.email}"
        save_error_record(new_user.id, 'new_user', 'error while saving a new employee record')
      end
    end
  end

  task :shifts => :environment do



    Migration::Shift.find_each do |legacy_shift|

      # do nothing if the shift has been migrated already

      unless legacy_shift.migrated
        # look up the old user associated with the shift
        begin
          legacy_user = Migration::User.find(legacy_shift.user_id)
        rescue
          puts "ERROR migrating legacy shift id #{legacy_shift.id.to_s}"
          save_error_record(legacy_shift.id, 'legacy_shift', 'Could not find the legacy user')
          next
        end

        # find the migrated employee record for the old user
        begin
          employee = Employee.find_by_legacy_id(legacy_user.id.to_s)
        rescue
          puts "ERROR looking up new employee record. Legacy shift id #{legacy_shift.id.to_s}"
          save_error_record(legacy_shift.id, 'legacy_shift', 'Could not find the legacy employee')
          next
        end

        # look up the shift type
        shift_type = ShiftType.find_by_name(legacy_shift.shift_type)

        begin
          new_shift = employee.shifts.build(shift_type_id: shift_type.id,
                                            date: legacy_shift.date,
                                            time_in: legacy_shift.time_in,
                                            time_out: legacy_shift.time_out,
                                            break_time: legacy_shift.break_time,
                                            notes: legacy_shift.notes,
                                            travel_reimb: legacy_shift.reimb_transit,
                                            created_at: legacy_shift.created_at,
                                            updated_at: legacy_shift.updated_at,
                                            legacy_id: legacy_shift.id.to_s,
                                            cv_shift: legacy_shift.cv_shift)
        rescue
          puts "ERROR building a new shift. Legacy shift id #{legacy_shift.id.to_s}"
          save_error_record(legacy_shift.id, 'legacy_shift', 'Error building the new shift')
          next
        end

        ## Save the shift
        if new_shift.save
          puts "Saved new shift id #{new_shift.id.to_s}"
          mark_as_migrated(legacy_shift)
        else
          puts "ERROR saving new shift. Legacy shift id #{legacy_shift.id.to_s}"
          save_error_record(legacy_shift.id, 'legacy_shift', 'Error saving the new shift')
        end
      end

    end
  end

  task :supporters => :environment do


    Migration::Supporter.find_each do |legacy_supporter|

      # do nothing if the supporter has been migrated already
      unless legacy_supporter.migrated

        puts "Migrating legacy supporter id #{legacy_supporter.id.to_s}"

        new_supporter_attributes = {
            legacy_id:            legacy_supporter.id,
            cim_id:               legacy_supporter.authorize_id,
            salutation:           legacy_supporter.salutation,
            first_name:           legacy_supporter.first_name,
            last_name:            legacy_supporter.last_name,
            suffix:               legacy_supporter.suffix,
            address1:             legacy_supporter.billing_street,
            address2:             legacy_supporter.billing_street_2,
            address_city:         legacy_supporter.billing_city,
            address_state:        legacy_supporter.billing_state,
            address_zip:          legacy_supporter.billing_zip,
            email_1:              legacy_supporter.email,
            phone_mobile:         legacy_supporter.mobile_phone,
            phone_home:           legacy_supporter.home_phone,
            phone_alt:            legacy_supporter.work_phone,
            do_not_mail:          legacy_supporter.do_not_mail,
            do_not_call:          legacy_supporter.do_not_call,
            do_not_email:         legacy_supporter.do_not_email,
            keep_informed:        legacy_supporter.keep_informed,
            vol_level:            legacy_supporter.vol_level,
            employer:             legacy_supporter.employer,
            occupation:           legacy_supporter.occupation,
            source:               legacy_supporter.source,
            notes:                legacy_supporter.notes,
            cim_customer_id:      legacy_supporter.id.to_s,
            created_at:           legacy_supporter.created_at,
            updated_at:           legacy_supporter.updated_at
        }

        ## Assign the new supporter id and sendy listbased on legacy flags or donations
        new_supporter_type_id = SupporterType.find_by_name('supporter').id #default
        new_sendy_list_id = SendyList.find_by_name('supporters').id #default

        if legacy_supporter.major_donor
          new_supporter_type_id = SupporterType.find_by_name('major_donor').id
          new_sendy_list_id = SendyList.find_by_name('major_donors').id
          puts "Found new major donor contact"
        elsif legacy_supporter.political
          new_supporter_type_id = SupporterType.find_by_name('political_contact').id
          new_sendy_list_id = SendyList.find_by_name('political_contacts').id
          puts "Found new major political contact"
        end

        new_supporter_attributes[:supporter_type_id] = new_supporter_type_id
        new_supporter_attributes[:sendy_list_id] = new_sendy_list_id


        ## save. if save successful: create sendy update record, attempt to update cim profile

        new_supporter = Supporter.new(new_supporter_attributes)

        if new_supporter.save
          puts "Saved new supporter. New id: #{new_supporter.id.to_s}, legacy id: #{legacy_supporter.id.to_s}"
          mark_as_migrated(legacy_supporter)

          #do api stuff
          if new_supporter.email_1.present? && !new_supporter.do_not_email
            sendy_update = SendyUpdateService.new(new_supporter.id, new_sendy_list_id, new_supporter.email_1, new_supporter.email_1)
            if sendy_update.update('subscribe')
              puts "Saved SendyUpdate record"
            else
              save_error_record(legacy_supporter.id , 'legacy_supporter', 'failed to save Sendy update record')
            end
          end

        else
          puts "ERROR migrating legacy supporter id #{legacy_supporter.id.to_s}"
          save_error_record(legacy_supporter.id, 'legacy_supporter', 'Error migrating legacy supporter')
        end
      end

    end
  end

  task :donations => :environment do

    Migration::Donation.find_each do |legacy_donation|

      ## flags and message. reset for each donation
      success = false
      message = ""

      # skip the record if it has already been migrated
      unless legacy_donation.migrated

        new_supporter = Supporter.find_by legacy_id: legacy_donation.supporter_id.to_s
        new_shift = Shift.find_by legacy_id: legacy_donation.shift_id.to_s

        if new_supporter


            new_donation_attributes = {
                shift_id:       (new_shift ? new_shift.id.to_s : ""),
                legacy_id:      legacy_donation.id,
                date:           legacy_donation.date,
                donation_type:  legacy_donation.donation_type,
                source:         legacy_donation.source,
                campaign:       legacy_donation.campaign,
                cancelled:      legacy_donation.canceled,
                notes:          legacy_donation.notes,
                amount:         legacy_donation.amount,
                sub_month:      legacy_donation.sub_month,
                sub_week:       legacy_donation.sub_week,
                created_at:     legacy_donation.created_at,
                updated_at:     legacy_donation.updated_at
            }

            new_donation = new_supporter.donations.build(new_donation_attributes)

            if new_donation.save
              success = true
            end

        else
          message = "Could not find the new supporter record. Supporter id #{legacy_donation.supporter_id}"
        end

        if success
          puts "Created new donation id #{new_donation.id.to_s} legacy donation id #{legacy_donation.id}"
          mark_as_migrated(legacy_donation)
        else
          save_error_record(legacy_donation.id, 'legacy_donation', message)
        end
      end
    end
  end

  task :payments => :environment do

    Migration::Payment.find_each do |legacy_payment|

      ## flags and message. reset for each donation
      success = false
      message = ""

      unless legacy_payment.migrated

        new_donation = Donation.find_by_legacy_id(legacy_payment.donation_id)

        if new_donation

          new_supporter = new_donation.supporter

          new_payment_profile_attributes = {
              supporter_id:           new_supporter.id,
              cim_payment_profile_id: legacy_payment.authorize_payment_profile_id,
              payment_profile_type:   legacy_payment.payment_type,
              cc_last_4:              legacy_payment.cc_last_4,
              cc_type:                legacy_payment.cc_type,
              cc_month:               legacy_payment.cc_month,
              cc_year:                legacy_payment.cc_year
          }
          if new_payment_profile = PaymentProfile.create(new_payment_profile_attributes)

            new_payment_attributes = {
                payment_profile_id: new_payment_profile.id,
                legacy_id:          legacy_payment.id,
                cim_auth_code:      legacy_payment.authorization_code,
                deposited_at:       legacy_payment.submit_time,
                payment_type:       legacy_payment.payment_type,
                captured:           legacy_payment.captured,
                processed:          legacy_payment.processed,
                amount:             legacy_payment.amount,
                created_at:         legacy_payment.created_at,
                updated_at:         legacy_payment.updated_at,
                receipt_sent_at:    Time.now
            }

            new_payment = new_donation.payments.build(new_payment_attributes)

            if new_payment.save
              success = true

            end

          else
            message = "Could not create new payment profile. legacy payment id #{legacy_payment.id}"
          end

        else
          message = "Could not find new donation record. legacy payment id #{legacy_payment.id}"
        end


        if success
          puts "Saved new payment id #{new_payment.id.to_s}"
          mark_as_migrated(legacy_payment)
        else
          save_error_record(legacy_payment.id, 'legacy_payment', message)
        end
      end
    end
  end

  task :city_council => :environment do

    supporter_type = SupporterType.find_by_name('city_council')
    sendy_list = SendyList.find_by_name('city_council')

    s3 = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    file = s3.buckets['staffnet2-import'].objects['city_council_2.csv'].read

    CSV.parse(file, headers: true) do |row|
      data = row.to_hash
      new_supporter_attributes = {
          prefix:               data['title'],
          first_name:           (data['first_name'].titlecase if data['first_name']),
          last_name:            (data['last_name'].titlecase if data['last_name']),
          address_city:         (data['city'].titlecase if data['city']),
          address_county:       (data['county'].titlecase if data['county']),
          email_1:              (data['email'].downcase if data['email'])
      }



      if data['phone_type'] == 'work'
        new_supporter_attributes[:phone_alt] = data['phone']
      else
        new_supporter_attributes[:phone_mobile] = data['phone']
      end

      new_supporter_attributes[:sendy_list_id] = sendy_list.id

      new_supporter = supporter_type.supporters.build(new_supporter_attributes)

      if new_supporter.save
        puts "saved new city council person id #{new_supporter.id.to_s}"

        # create a Sendy record
        if new_supporter.email_1.present?
          sendy_update = SendyUpdateService.new(new_supporter.id, sendy_list.id, new_supporter.email_1, new_supporter.email_1)
          if sendy_update.update('subscribe')
            puts "Saved SendyUpdate record"
          else
            save_error_record(0, 'city_council', "problem saving city council person #{data['last_name']}")
          end
        end

        # create a CIM record
        new_supporter.generate_cim_customer_id
        cim_record = CimCustProfileService.new(new_supporter.cim_customer_id, new_supporter.email_1, '')
        cim_record.create
          new_supporter.cim_id = cim_record.cim_id
          new_supporter.save
          puts "Created CIM profile for id #{new_supporter.id}. CIM id #{new_supporter.cim_id}"
      else
        save_error_record(0, 'city_council', "problem saving city council person #{data['last_name']}")
      end

    end
  end

  task :school_board => :environment do

    supporter_type = SupporterType.find_by_name('school_board')
    sendy_list = SendyList.find_by_name('school_board')

    AWS::S3::Base.establish_connection!( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                         secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    #file = AWS::S3::S3Object.value('school_board.csv', 'staffnet2-import')

    CSV.parse(file, headers: true) do |row|
      data = row.to_hash
      new_supporter_attributes = {
          prefix:               data['title'],
          first_name:           data['first_name'],
          last_name:            data['last_name'],
          address_city:         data['city'],
          address_county:       data['county'],
          email_1:              data['email'],
          notes:                data['district']
      }

      if data['phone_type'] == 'work'
        new_supporter_attributes[:phone_alt] = data['phone']
      else
        new_supporter_attributes[:phone_mobile] = data['phone']
      end

      new_supporter_attributes[:sendy_list_id] = sendy_list.id

      new_supporter = supporter_type.supporters.build(new_supporter_attributes)

      if new_supporter.save
        puts "saved new school board person id #{new_supporter.id.to_s}"
        if new_supporter.email_1.present?
          sendy_update = SendyUpdateService.new(new_supporter.id, sendy_list.id, new_supporter.email_1, new_supporter.email_1)
          if sendy_update.update('subscribe')
            puts "Saved SendyUpdate record"
          else
            save_error_record(0, 'school_board', "problem saving school board person #{data['last_name']}")
          end
        end
      else
        save_error_record(0, 'city_council', "problem saving school board person #{data['last_name']}")
      end

    end
  end

  task :nb_extras => :environment do

    new_sendy_list_id = SendyList.find_by_name('supporters').id #default


    s3 = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    #file = AWS::S3::S3Object.value('nb_dnc.csv', 'staffnet2-import')
    file = s3.buckets['staffnet2-import'].objects['nb_extras.csv'].read

    if file
      puts "downloaded import file"
      CSV.parse(file, headers: true) do |row|

        puts "reading first row"
        data = row.to_hash

        emails = []
        emails << data['email1']
        emails << data['email2']
        emails << data['email3']

        emails.each do |email|
          puts "looking up #{email}"
          supporter = Supporter.find_by email_1: email
          if supporter
            puts "found existing supporter"
          else
            new_supporter = Supporter.build( email_1: email )
            new_supporter.first_name = data['first_name'] if data['first_name']
            new_supporter.last_name = data['last_name'] if data['last_name']
            if new_supporter.save
              puts "created new supporter"
              sendy_update = SendyUpdateService.new(new_supporter.id, new_sendy_list_id, new_supporter.email_1, new_supporter.email_1)
              if sendy_update.update('subscribe')
                puts "Saved SendyUpdate record"
              end
            else
              puts "problem creating new suppporter. email #{email}"

            end
          end
        end
      end

    end
  end

  task :nb_dnc => :environment do

    s3 = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                         secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    #file = AWS::S3::S3Object.value('nb_dnc.csv', 'staffnet2-import')
    file = s3.buckets['staffnet2-import'].objects['nb_dnc.csv'].read

    if file
      puts "downloaded import file"

      CSV.parse(file, headers: true) do |row|
        puts "reading first row"
        data = row.to_hash

        emails = []
        emails << data['email1']
        emails << data['email2']
        emails << data['email3']

        emails.each do |email|
          puts "looking up #{email}"
          supporter = Supporter.find_by email_1: email
          if supporter
            "Found supporter #{supporter.full_name} id #{supporter.id}"
            if data['do_not_contact'] == 'true'
              if supporter.do_not_contact
                puts "Already a dnc"
              else
                supporter.do_not_contact = true

                ## also must unsub from sendy!

                if supporter.save
                  puts "Successfuly marked as dnc"
                else
                  puts "Problem saving supporter record"
                end

              end
            end
          else
            puts "did not find supporter"
          end
        end
      end
    end

  end

  task :nb_unsubs => :environment do
    s3 = AWS::S3.new( access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] )

    #file = AWS::S3::S3Object.value('nb_dnc.csv', 'staffnet2-import')
    file = s3.buckets['staffnet2-import'].objects['nb_unsubs.csv'].read

    if file
      puts "downloaded import file"

      CSV.parse(file, headers: true) do |row|
        "reading first row"
        data = row.to_hash

        emails = []
        emails << data['email1']
        emails << data['email2']
        emails << data['email3']

        emails.each do |email|
          puts "looking up #{email}"
          supporter = Supporter.find_by email_1: email
          if supporter
            "Found supporter #{supporter.full_name} id #{supporter.id}"

            if SendyUpdate.create(  supporter_id:     supporter.id,
                                  sendy_list_id:    "NMpznzCK8qu892xT6Hupo7kg",   #supporters list
                                  sendy_email:      email,
                                  new_sendy_email:  email,
                                  action:           "unsubscribe")
              puts "created sendy update"
            else
              puts "problem creating sendy update"
            end
          else
            puts "did not find supporter"
          end
        end
      end
    end


  end

end