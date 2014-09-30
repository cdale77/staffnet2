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

require 'spec_helper'

describe Payment do

  payment_attributes = SpecData.payment_attributes

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
  it { should respond_to(:shift) }
  it { should respond_to(:payment_profile) }
  it { should respond_to(:deposit_batch) }

  ## CLASS METHODS
  describe 'payments to be batched' do
    before { 5.times { FactoryGirl.create(:payment) } }
    it 'should return the right payments' do
      Payment.to_be_batched.count.should eql 6
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
