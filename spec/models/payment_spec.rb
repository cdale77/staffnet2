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
#  captured           :boolean          default(FALSE)
#  processed          :boolean          default(FALSE)
#  amount             :decimal(8, 2)    default(0.0)
#  notes              :text             default("")
#  created_at         :datetime
#  updated_at         :datetime
#  receipt_sent_at    :datetime
#

require 'spec_helper'

describe Payment do

  payment_attributes = {  deposited_at: Time.now,
                          payment_type: "Credit Card",
                          captured: true,
                          processed: true,
                          cim_transaction_id: "112131231",
                          cim_auth_code: "12312312423",
                          amount: 10.00,
                          notes: "Notes" }

  let(:payment) { FactoryGirl.create(:payment) }

  ## ATTRIBUTES
  describe 'payment attribute tests' do
    payment_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter) }
  it { should respond_to(:donation) }
  it { should respond_to(:payment_profile) }
  it { should respond_to(:deposit_batch) }

  ## CLASS METHODS
  describe 'payments to be batched' do
    before { 5.times { FactoryGirl.create(:payment) } }
    it 'should return the right payments' do
      Payment.to_be_batched.count.should eql 5
    end
  end

  ## VALIDATIONS
  describe 'payment type validations' do
    it 'should require a payment type' do
      payment.payment_type = ""
      payment.should_not be_valid
    end
  end
  describe 'amount validations' do
    it 'should require a payment amount' do
      payment.amount = ""
      payment.should_not be_valid
    end
  end
end
