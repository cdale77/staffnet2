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

require 'spec_helper'

describe DepositBatch do

  deposit_batch_attributes = { date: Date.today,
                               deposited: false,
                               approved: false,
                               receipt_number: "2323002323232",
                               batch_type: 'installment' }

  let(:deposit_batch) { FactoryGirl.create(:deposit_batch) }

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
    it 'should return an array' do
      expect(DepositBatch.to_be_approved).to be_an_instance_of Array
    end
  end

  describe '::batch_up' do
    it 'should respond to the method' do
      expect(DepositBatch.batch_up).to be_truthy
    end
  end
end
