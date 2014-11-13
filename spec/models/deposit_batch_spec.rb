# == Schema Information
#
# Table name: deposit_batches
#
#  id             :integer          not null, primary key
#  employee_id    :integer
#  batch_type     :string(255)      default("")
#  date           :date
#  deposited      :boolean          default("false")
#  approved       :boolean          default("false")
#  receipt_number :string(255)      default("")
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe DepositBatch do

  deposit_batch_attributes = SpecData.deposit_batch_attributes

  let!(:deposit_batch) { FactoryGirl.create(:deposit_batch) }
  let!(:payment) { FactoryGirl.create(:payment, deposit_batch: deposit_batch) }

  subject { deposit_batch }

  ## ATTRIBUTES
  describe 'payment attribute tests' do
    deposit_batch_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:employee) }
  it { should respond_to(:payments) }

  ## CLASS METHODS
  describe '::to_be_approved' do
    it 'should respond to the method' do
      expect(DepositBatch.to_be_approved).to be_truthy
    end
  end

  describe '::installment_batches_to_be_approved' do
    it 'should respond to the method' do
      expect(DepositBatch.installment_batches_to_be_approved).to be_truthy
    end
  end

  describe '::batch_up' do
    it 'should respond to the method' do
      expect(DepositBatch.batch_up).to be_truthy
    end
  end

  ## INSTANCE METHODS
  describe '#processable?' do
    
    before do
      deposit_batch.batch_type = "installment"
      payment.processed = false
    end

    it 'should return true' do
      expect(deposit_batch.processable?).to be_truthy
    end
    it 'should return false' do
      payment.processed = true
      expect(deposit_batch.processable?).to be_falsey
    end
    it 'should return false' do 
      deposit_batch.batch_type = "credit"
      payment.processed = false
      expect(deposit_batch.processable?).to be_falsey
    end
  end
end

