require "active_job"

class SendyUpdateJob < ActiveJob::Base
  queue_as :default

  def perform
    #updates = SendyUpdate.where(success: false)
    #Sendy::PerformUpdates.perform(updates)
  end
end
