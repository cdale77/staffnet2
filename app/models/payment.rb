# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  payment_profile_id :integer
#  cim_transaction_id :string(255)      default("")
#  user_id            :integer
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
  belongs_to :donation
  has_one :payment_profile


  ## CALLBACKS
  #before_save :store_cc_info

  ## VALIDATIONS
  validates :payment_type, presence: { message: 'required.' }
  validates :amount, presence: { message: 'required.' }
end
