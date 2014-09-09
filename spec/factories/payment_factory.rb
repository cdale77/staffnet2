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

FactoryGirl.define do
  factory :payment do
    payment_type          'cash'
    captured              true
    amount                10.00
    processed             true
    receipt_sent_at       Time.now
    donation
  end

end
