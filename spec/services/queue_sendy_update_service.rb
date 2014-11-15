require 'spec_helper'

describe QueueSendyUpdateService do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let(:sendy_list) { FactoryGirl.create(:sendy_list) }
  let(:service) { QueueSendyUpdateService.new(
                            supporter_id: supporter.id, 
                            supporter_email: supporter.email_1, 
                            sendy_list_id: sendy_list.id, 
                            old_email: "oldemail@example.com") }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of QueueSendyUpdateService
    end
  end

  describe '#update' do
    it 'should create a SendyUpdate record' do
      expect { service.update("subscribe") }.to change(SendyUpdate, :count).by(1)
    end
    it 'should set success to true' do
      service.update("subscribe")
      service.success.should be_truthy
    end
  end
end

