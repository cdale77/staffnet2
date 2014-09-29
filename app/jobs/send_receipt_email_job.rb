require "active_job"

class SendReceiptEmailJob < ActiveJob::Base

  queue_as :default 

  def perform(payment_id)
    donation = Donation.find_by payment_id: payment_id
    supporter = donation.supporter 
    if donation && supporter 
      SupporterMailer.receipt(supporter, donation).deliver
    end
  end
end
