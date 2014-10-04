require "active_job"

class ResolveDuplicateRecordsJob < ActiveJob::Base 
  queue_as :default 

  def perform(params)
    service = ResolveDuplicateRecordsService.new(params)
    service.perform
  end
end
