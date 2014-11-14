desc 'Heroku scheduler file'

task :update_sendy => :environment do
  SendyUpdateJob.perform_later
end

task :calculate_employee_stats => :environment do
  EmployeeFundraisingCalculationsJob.perform_later
end

task :sub_week_5_to_4 => :environment do
  SubWeek5To4Job.perform_later
end

task :employee_fundraising_calculations => :environment do
  EmployeeFundraisingCalculationsJob.perform_later
end

task :update_prospect_group => :environment do
  UpdateProspectGroupJob.perform_later
end

task :clean_data => :environment do
  CleanDataJob.perform_late
end
