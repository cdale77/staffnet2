namespace :payroll do
  desc "Create payroll records"

  task create: :environment do
    PayrollProcessingJob.enqueue
  end
end