desc 'Heroku scheduler file'
namespace :scheduler do 

  task :update_sendy => :environment do
    PerformSendyUpdatesService.new.perform
  end

  task :calculate_employee_stats => :environment do
    EmployeeFundraisingCalculationsJob.perform_later()
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

  task :update_prospect_group => :environment do
    UpdateProspectGroupJob.perform_later()
  end

  task :clean_data => :environment do
    CleanDataJob.perform_later()
  end

end

