# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  payment_profile_id :integer
#  deposit_batch_id   :integer
#  legacy_id          :string(255)      default("")
#  cim_transaction_id :string(255)      default("")
#  cim_auth_code      :string(255)      default("")
#  deposited_at       :date
#  payment_type       :string(255)      default("")
#  captured           :boolean          default("false")
#  processed          :boolean          default("false")
#  amount             :decimal(8, 2)    default("0.0")
#  notes              :text             default("")
#  created_at         :datetime
#  updated_at         :datetime
#  receipt_sent_at    :datetime
#

class Payment < ActiveRecord::Base

  has_paper_trail

  default_scope { order(created_at: :desc) }

  ## RELATIONSHIPS
  delegate :supporter, to: :donation
  belongs_to :donation
  delegate :shift, to: :donation
  belongs_to :payment_profile
  belongs_to :deposit_batch

  ## VALIDATIONS
  validates :payment_type, presence: { message: "required" }
  validates :amount, presence: { message: "required" }

  def self.to_be_batched
    where(deposit_batch_id: nil)
  end

  def self.create_installment_payments
    current_sustainers = Donation.sustaining_donations
    deposit_batch = DepositBatch.create(batch_type: "installment",
                                        date: Date.today)

    sustaining_donations_to_process = current_sustainers.select do |sustainer|
      ( sustainer.sub_month == Donation.current_quarter_code || sustainer.sub_month == "m") && \
      sustainer.sub_week == Date.today.week_of_month
    end

    sustaining_donations_to_process.each do |sustaining_donation|
      puts "creating installment payment for donation id #{sustaining_donation.id}"
      previous_payment = sustaining_donation.payments.first
      payment = sustaining_donation.payments.build
      payment.deposit_batch_id = deposit_batch.id
      payment.payment_profile_id = previous_payment.payment_profile_id
      payment.payment_type = "installment"
      payment.amount = sustaining_donation.amount
      if payment.save
        puts "successfully saved payment"
      else
        puts "error saving payment"
      end
    end
  end

  def process_payment
    unless self.processed
      if self.payment_type == "credit" || self.payment_type == "installment"
        charge = Cim::ProfilePayment.new(self.supporter.cim_id,
                                         self.payment_profile.cim_payment_profile_id,
                                         self.amount)
        if charge.process
          self.cim_transaction_id = charge.cim_transaction_id
          self.cim_auth_code = charge.cim_auth_code
          self.deposited_at = Date.today
          self.captured = true
        end

        self.processed = true
        self.notes = charge.server_message + "--" + self.notes
      else
        self.captured = true # anything but a credit payment considered captured
        self.processed = true
      end
    end
  end

  def send_receipt
    unless self.receipt_sent_at.present?
      supporter = self.donation.supporter
      if supporter.email_1.present?
        SendReceiptEmailJob.enqueue(self.donation_id)
        self.receipt_sent_at = Time.now
      end
    end
  end
end
