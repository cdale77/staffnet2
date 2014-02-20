# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  payment_profile_id :integer
#  legacy_id          :string(255)      default("")
#  cim_transaction_id :string(255)      default("")
#  cim_auth_code      :string(255)      default("")
#  deposited_at       :date
#  payment_type       :string(255)      default("")
#  captured           :boolean          default(FALSE)
#  processed          :boolean          default(FALSE)
#  amount             :decimal(8, 2)    default(0.0)
#  notes              :text             default("")
#  created_at         :datetime
#  updated_at         :datetime
#

class Payment < ActiveRecord::Base

  ## RELATIONSHIPS
  delegate :supporter, to: :donation
  belongs_to :donation
  belongs_to :payment_profile, dependent: :destroy

  ## CALLBACKS
  before_save :process_payment

  ## VALIDATIONS
  validates :payment_type, presence: { message: 'required.' }
  validates :amount, presence: { message: 'required.' }

  def process_payment
    unless self.processed
      if self.payment_type == 'credit'
        charge = Cim::ProfilePayment.new(self.supporter.cim_id, self.payment_profile.cim_payment_profile_id, self.amount)
        if charge.process
          self.cim_transaction_id = charge.cim_transaction_id
          self.cim_auth_code = charge.cim_auth_code
          self.captured = true
        end
        self.notes = charge.server_message + "--" + self.notes
      else
        self.captured = true # anything but a credit payment considered captured
      end
      self.processed = true
    end
  end
end
