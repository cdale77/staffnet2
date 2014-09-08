desc 'Heroku scheduler file'

task :update_sendy => :environment do
  SendyUpdateJob.enqueue
end

task :calculate_employee_stats => :environment do
  EmployeeFundraisingCalculationsJob.enqueue
end

task :sub_week_5_to_4 => :environment do
  donations = Donation.where(sub_week: 5)
  puts "Updating #{donations.count} donations"
  donations.each do |donation|
    if donation.update_columns(sub_week: 4)
      puts "Updated donation id #{donation.id}"
    else
      puts "Could not update donation id #{donation.id}"
    end
  end
end

task :employee_fundraising_calculations => :environment do
  EmployeeFundraisingCalculationsJob.enqueue
end