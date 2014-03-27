namespace :import do

  def save_error_record(record_id, record_name, message)
    MigrationError.create(record_id: record_id, record_name: record_name, message: message)
  end

  task :prepare => :environment do

    supporter_type = SupporterType.create(name: 'supporter')
    major_donor_type = SupporterType.create(name: 'major_donor')
    political_type = SupporterType.create(name: 'political')

    puts "What is the Sendy list id for the supporters list?"
    sendy_list_id = STDIN.gets.chomp
    supporter_type.sendy_lists.create(name: 'supporters', sendy_list_identifier: sendy_list_id )


    puts "What is the Sendy list id for the major_donors list?"
    sendy_list_id = STDIN.gets.chomp
    major_donor_type.sendy_lists.create(name: 'major_donors', sendy_list_identifier: sendy_list_id)


    puts "What is the Sendy list id for the political contacts list?"
    sendy_list_id = STDIN.gets.chomp
    political_type.sendy_lists.create(name: 'political_contacts', sendy_list_identifier: sendy_list_id)
  end

  task :users_and_employees => :environment do
    legacy_users = Migration::User.all
    puts "Migrating #{legacy_users.count.to_s} legacy users. . . "
    legacy_users.each do |legacy_user|
      new_password = SecureRandom.hex(7)
      begin
        new_user = User.new(email: legacy_user.email, password: new_password,
                            password_confirmation: new_password, role: 'staff')
      rescue
        puts "ERROR migrating legacy user #{legacy_user.id.to_s}. Could not create new user."
        save_error_record(legacy_user.id, 'legacy_user', 'Could not instantiate new user object')
        next
      end

      begin
        if new_user.save
          puts "New password for #{new_user.email}: #{new_password}"
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
                                                created_at: legacy_user.created_at, legacy_id: legacy_user.id.to_s,
                                              )
      rescue
        puts "ERROR creating employee record for #{new_user.email}"
        save_error_record(new_user.id, 'new_user', 'error while building a new employee record')
        next
      end

      begin
        new_employee.save
      rescue
        puts "ERROR saving employee record for #{new_user.email}"
        save_error_record(new_user.id, 'new_user', 'error while saving a new employee record')
        next
      end
    end
  end

  task :shifts => :environment do

    ## Create shift types
    names = ['door', 'street', 'phone', 'office', 'vacation', 'holiday', 'sick' ]
    names.each do |name|
      new_type = ShiftType.new(name: name)
      new_type.save
    end

    Migration::Shift.find_each do |legacy_shift|

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


      begin
        new_shift = employee.shifts.build(shift_type_id: ShiftType.find_by_name(legacy_shift.shift_type),
                                          date: legacy_shift.date,
                                          time_in: legacy_shift.time_in,
                                          time_out: legacy_shift.time_out,
                                          break_time: legacy_shift.break_time,
                                          notes: legacy_shift.notes,
                                          travel_reimb: legacy_shift.reimb_transit,
                                          created_at: legacy_shift.created_at,
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
      else
        puts "ERROR saving new shift. Legacy shift id #{legacy_shift.id.to_s}"
        save_error_record(legacy_shift.id, 'legacy_shift', 'Error saving the new shift')
      end
    end
  end

  task :supporters => :environment do

    Migration::Supporter.find_each do |legacy_supporter|

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
          notes:                legacy_supporter.notes
      }

      ## Assign the new supporter id and sendy listbased on legacy flags or donations
      new_supporter_type_id = SupporterType.find_by_name('supporter').id #default
      new_sendy_list_id = SendyList.find_by_name('supporters').id #default

      if legacy_supporter.political
        new_supporter_type_id = SupporterType.find_by_name('political').id
        new_sendy_list_id = SendyList.find_by_name('political_contacts').id
        puts "Found new political contact"
      elsif legacy_supporter.major_donor
        new_supporter_type_id = SupporterType.find_by_name('major_donor').id
        new_sendy_list_id = SendyList.find_by_name('major_donors').id
        puts "Found new major donor contact"
      end

      new_supporter_attributes[:supporter_type_id] = new_supporter_type_id
      new_supporter_attributes[:sendy_list_id] = new_sendy_list_id


      ## save. if save successful: create sendy update record, attempt to update cim profile

      new_supporter = Supporter.new(new_supporter_attributes)

      if new_supporter.save
        puts "Saved new supporter. New id: #{new_supporter.id.to_s}, legacy id: #{legacy_supporter.id.to_s}"

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

  task :donations => :environment do

    Migration::Donation.find_each do |legacy_donation|
      legacy_supporter = Migration::Supporter.find(legacy_donation.supporter_id)
      new_supporter = Supporer.find_by_legacy_id(legacy_supporter.id)

      new_donation_attributes = {
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
      }


      new_donation = new_supporter.donations.build(new_donation_attributes)

      unless new_donation.save
        save_error_record(legacy_donation.id, 'legacy_donation', 'error saving legacy donation')
      end
    end
  end


end