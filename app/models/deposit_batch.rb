# == Schema Information
#
# Table name: deposit_batches
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  batch_type     :string(255)      default("")
#  date           :date
#  deposited      :boolean          default(FALSE)
#  approved       :boolean          default(FALSE)
#  receipt_number :string(255)      default("")
#  created_at     :datetime
#  updated_at     :datetime
#

class DepositBatch < ActiveRecord::Base

  has_paper_trail

  default_scope { order(date: :desc) }

  belongs_to :employee
  has_many :payments

  # return a collection of batches that need to be approved
  # combine results from batch up, with sustainer payments that need
  # to be created, with non-approved existing batches
  def self.to_be_approved
    where(approved: false)
  end

  def self.installment_batches_to_be_approved
    where("batch_type = 'installment' AND approved = false")
  end

  def payments_by_shift
    self.payments.sort_by { |payment| payment.shift }
  end


  # create new batches from un-batched payments
  def self.batch_up

    # get the payments to be batched
    payments = Payment.to_be_batched

    # sort by type. example - types["check"] gives the check payments
    type_batches = payments.group_by { |payment| payment.payment_type }

    type_names = %w[credit cash check retry installment]

    type_names.each do |type_name|
      type_batch = type_batches.delete(type_name)
      if type_batch
        date_batches = type_batch.group_by { |payment| payment.created_at.to_date }
        date_batches.each do |k,v|
          batch = DepositBatch.create(batch_type: type_name, date: k)
          v.each do |payment|
            payment.deposit_batch_id = batch.id
            payment.save
          end
        end
      end
    end
  end

  def processable?
    if batch_type == "installment" && self.payments.where(processed: false).any?
      return true
    else
      return false
    end
  end
end

