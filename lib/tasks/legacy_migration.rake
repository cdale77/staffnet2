namespace :import do
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
        next
      end

      begin
        if new_user.save
          puts "New password for #{new_user.email}: #{new_password}"
        else
          puts "Could not save user record for #{new_user.email}"
          puts new_user.errors.full_messages
        end
      rescue
        puts "Exception migrating legacy user #{legacy_user.id.to_s}. Could not save user."
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
        next
      end

      begin
        new_employee.save
      rescue
        puts "ERROR saving employee record for #{new_user.email}"
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

    legacy_shifts = Migration::Shift.all
    puts "Migrating #{legacy_shifts.count.to_s} legacy shifts. . . "
    legacy_shifts.all.each.with_index(1) do |legacy_shift, index|
      begin
        legacy_user = Migration::User.find(legacy_shift.user_id)
      rescue
        puts "ERROR migrating legacy shift id #{legacy_shift.id.to_s}"
        next
      end

      begin
        employee = Employee.find_by_legacy_id(legacy_user.id.to_s)
      rescue
        puts "ERROR looking up new employee record. Legacy shift id #{legacy_shift.id.to_s}"
        next
      end

      begin
        new_shift = employee.shifts.build(shift_type_id: ShiftType.find_by_name(legacy_shift.shift_type),
                                          date: legacy_shift.date, time_in: legacy_shift.time_in,
                                          time_out: legacy_shift.time_out, break_time: legacy_shift.break_time,
                                          notes: legacy_shift.notes, travel_reimb: legacy_shift.reimb_transit,
                                          created_at: legacy_shift.created_at, legacy_id: legacy_shift.id.to_s,
                                          cv_shift: legacy_shift.cv_shift)
      rescue
        puts "ERROR building a new shift. Legacy shift id #{legacy_shift.id.to_s}"
        next
      end

      ## Save the shift
      puts "ERROR saving new shift. Legacy shift id #{legacy_shift.id.to_s}" unless new_shift.save

      ## Check
      if index == legacy_shifts.count
        puts "Created #{Shift.all.count.to_s} new shifts from #{legacy_shifts.count.to_s} legacy shifts"
      end
    end
  end

  task :supporters => :environment do

    ## before running the migration, create supporter types and sendy lists.

    Migration::Supporter.all.limit(10).each do |legacy_supporter|

      puts "Migrating first legacy supporter id #{legacy_supporter.id.to_s}"

      new_supporter_attributes = {
          legacy_id:            legacy_supporter.id,
          cim_id:               legacy_supporter.authorize_id,
          salutation:           legacy_supporter.salutation,
          first_name:           legacy_supporter.first_name,
          last_name:            legacy_supporter.last_name,
          suffix:               legacy_supporter.suffix,
          address1:             legacy_supporter.billing_street,
          address2:             legacy_supporter.billing_street2,
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
      new_supporter_type_id = SupporterType.where(name: 'supporter').id #default
      new_sendy_list_id = SendyList.where(name: 'supporters').id #default

      if legacy_supporter.political
        new_supporter_type_id = SupporterType.where(name: 'political').id
        new_sendy_list_id = SendyList.where(name: 'political_contacts').id
        puts "Found new political contact"
      elsif legacy_supporter.major_donor
        new_supporter_type_id = SupporterType.where(name: 'major_donor').id
        new_sendy_list_id = SendyList.where(name: 'major_donors').id
        puts "Found new major donor contact"
      end

      new_supporter_attributes[:supporter_type_id] = new_supporter_type_id
      new_supporter_attributes[:sendy_list_id] = new_sendy_list_id


      ## save. if save successful: create sendy update record, attempt to update cim profile

      new_supporter = Supporter.new(new_supporter_attributes)

      if new_supporter.save
        puts "Saved new supporter. New id: #{supporter.id.to_s}, legacy id: #{legacy_supporter.id.to_s}"
        #do api stuff
        if new_supporter.email_1.present? && !new_supporter_attributes.do_not_email
          sendy_update = SendyUpdateService.new(new_supporter.id, new_sendy_list_id, new_supporter.email_1)
          if sendy_update.update('subscribe')
            puts "Saved SendyUpdate record"
          end
        end
      else
        puts "ERROR migrating legacy supporter id #{legacy_supporter.id.to_s} !"
      end
    end
  end
end