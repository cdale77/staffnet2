require 'spec_helper'

describe PerformSendyUpdatesService do

  #let!(:supporter) { FactoryGirl.create(:supporter) }
  #let(:sendy_list) { FactoryGirl.create(:sendy_list) }
  let(:service) { PerformSendyUpdatesService.new }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of PerformSendyUpdatesService
    end
  end
end

