require "active_job"

class CreateDuplicateRecordsJob < ActiveJob::Base 
  queue_as :default 

  def perform(file_path)
    service = CreateDuplicateRecordsService.new(file_path: file_path)
    service.perform
  end
end
