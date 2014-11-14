require "spec_helper"

describe DepositBatchProcessingService do

  let!(:deposit_batch) { FactoryGirl.create(:deposit_batch) }
  let!(:service) { DepositBatchProcessingService.new(deposit_batch) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of DepositBatchProcessingService
    end
  end
end

