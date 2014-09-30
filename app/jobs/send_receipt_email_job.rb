require "active_job"

class SendReceiptEmailJob < ActiveJob::Base

  queue_as :default 

  def perform(donation_id, cim_auth_code)
    donation = Donation.find(donation_id)
    supporter = donation.supporter 
    if donation && supporter 
      SupporterMailer.receipt(supporter, donation, cim_auth_code).deliver
    end
  end
end
