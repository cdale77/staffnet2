require "active_job"

class PayrollProcessingJob < ActiveJob::Base
  queue_as :default


  def perform
    service = CreatePayrollService.new
    service.perform
  end
end