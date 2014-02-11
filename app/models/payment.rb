# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  payment_profile_id :integer
#  cim_transaction_id :string(255)      default("")
#  deposited_at       :date
#  payment_type       :string(255)      default("")
#  captured           :boolean          default(FALSE)
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
  #before_save :charge_cc

  ## VALIDATIONS
  validates :payment_type, presence: { message: 'required.' }
  validates :amount, presence: { message: 'required.' }

  private

    def charge_cc
      if self.payment_type == 'credit'
        charge = Cim::ProfilePayment.new(self.supporter.cim_id, self.payment_profile.cim_payment_profile_id, self.amount)
      end
    end

end
