require "active_job"

class InstallmentPaymentsJob < ActiveJob::Base
  queue_as :default

  def perform(batch_id)
    batch = DepositBatch.find(batch_id.to_i)

    if batch
      payments = batch.payments

      payments.each do |payment|
        puts "Processing installment payment id #{payment.id}"
        begin
          payment.process_payment
        rescue
          puts "Error processing payment id #{payment.id}"
        end

        if payment.save
          puts "Saved payment details for id #{payment.id}"
        else
          puts "Error saving payment details"
        end
      end
    end
  end
end
