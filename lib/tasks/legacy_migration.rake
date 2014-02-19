namespace :import do
  task :users_and_staff => :environment do
    legacy_users = Migration::User.all
    puts "Migrating #{legacy_users.count.to_s} legacy users. . . "
    legacy_users.each do |legacy_user|
      new_password = SecureRandom.hex(7)
      begin
        new_user = User.new(email: legacy_user.email, password: new_password, password_confirmation: new_password)
      rescue
        puts "ERROR migrating legacy user #{legacy_user.id.to_s}"
      end

      begin
        new_user.save
      rescue
        puts "ERROR migrating legacy user #{legacy_user.id.to_s}"
      end
      puts "New password for #{new_user.email}: #{new_password}"
    end
  end
end