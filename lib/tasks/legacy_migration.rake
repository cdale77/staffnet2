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
                                                created_at: legacy_user.created_at, legacy_id: legacy_user.id.to_s
                                              )
      rescue
        puts "ERROR creating employee record for #{new_user.email}"
      end

      begin
        new_employee.save
      rescue
        puts "ERROR saving employee record for #{new_user.email}"
      end
    end
  end
end