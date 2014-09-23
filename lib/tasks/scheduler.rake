erodesc 'Heroku scheduler file'

task :update_sendy => :environment do
  SendyUpdateJob.enqueue
end

task :calculate_employee_stats => :environment do
  EmployeeFundraisingCalculationsJob.enqueue
end

task :sub_week_5_to_4 => :environment do
  SubWeek5To4Job.enqueue
end

task :employee_fundraising_calculations => :environment do
  EmployeeFundraisingCalculationsJob.enqueue
end
