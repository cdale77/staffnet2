require "active_job"

class SendReceiptEmailJob < ActiveJob::Base

  queue_as :default 

  def perform(payment_id)
    donation = Payment.find(payment_id).donation
    supporter = donation.supporter 
    if donation && supporter 
      SupporterMailer.receipt(supporter, donation).deliver
    end
  end
end
