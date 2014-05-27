# == Schema Information
#
# Table name: deposit_batches
#
#  id         :integer          not null, primary key
#  batch_type :string(255)      default("")
#  date       :date
#  deposited  :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe DepositBatch do

  deposit_batch_attributes = { date: Date.today, deposited: true, batch_type: 'installment' }

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


end
