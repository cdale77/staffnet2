# == Schema Information
#
# Table name: deposit_batches
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  batch_type     :string(255)      default("")
#  date           :date
#  deposited      :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  approved       :boolean          default(FALSE)
#  receipt_number :string(255)      default("")
#

class DepositBatch < ActiveRecord::Base

  belongs_to :employee
  has_many :payments

  # return a collection of batches that need to be approved
  # combine results from batch up, with sustainer payments that need
  # to be created, with non-approved existing batches
  def self.to_be_approved
    []
  end

  # create new batches from un-batched payments
  def self.batch_up

    # get the payments to be batched
    payments = Payment.to_be_batched

    # sort by type. example - types["check"] gives the check payments
    types = payments.group_by { |payment| payment.payment_type }

    # batch up the cash and credit types
    cash_payments = types.delete("cash")
    one_time_cc_payments = types.delete("credit")

    if cash_payments
      batches = cash_payments.group_by { |payment| payment.donation.date }
      batches.each do |k,v|
        batch = DepositBatch.create(batch_type: "cash", date: k)
        v.each do |payment|
          payment.deposit_batch_id = batch.id
          payment.save
        end
      end
    end

    if one_time_cc_payments
      batches = cash_payments.group_by { |payment| payment.donation.date }
      batches.each do |k,v|
        batch = DepositBatch.create(batch_type: "credit", date: k)
        v.deposit_batch_id = batch.id
        v.save
      end
    end

    # deal with the other types (installment, retry, etc)
  end


end
