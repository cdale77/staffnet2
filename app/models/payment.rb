# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  cim_profile_id     :string(255)      default("")
#  cim_transaction_id :string(255)      default("")
#  user_id            :integer
#  deposited_at       :date
#  payment_type       :string(255)      default("")
#  captured           :boolean          default(FALSE)
#  amount             :decimal(8, 2)    default(0.0)
#  cc_last_4          :string(4)        default("")
#  cc_month           :string(2)        default("")
#  cc_year            :string(4)        default("")
#  cc_type            :string(255)      default("")
#  check_number       :string(255)      default("")
#

class Payment < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :donation

  ## VALIDATIONS
  validates :payment_type, presence: { message: 'required.' }

  validates :amount, presence: { message: 'required.' }
end
