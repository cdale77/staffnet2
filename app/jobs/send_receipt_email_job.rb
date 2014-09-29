require "active_job"

class SendReceiptEmailJob < ActiveJob::Base

  queue_as :default 

  def perform(donation_id)
    donation = Donation.find(donation_id)
    supporter = donation.supporter 
    if donation && supporter 
      SupporterMailer.receipt(supporter, donation).deliver
    end
  end
end
