require 'spec_helper'

describe SendyUpdateService do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let(:sendy_list) { FactoryGirl.create(:sendy_list) }
  let(:sendy_service) { SendyUpdateService.new(
                            supporter_id: supporter.id, 
                            supporter_email: supporter.email_1, 
                            sendy_list_id: sendy_list.id, 
                            old_email: "oldemail@example.com") }

  describe '#initialize' do
    it 'should create an object' do
      sendy_service.should be_an_instance_of SendyUpdateService
    end
  end

  describe '#update' do
    it 'should create a SendyUpdate record' do
      expect { sendy_service.update("subscribe") }.to change(SendyUpdate, :count).by(1)
    end
    it 'should set success to true' do
      sendy_service.update("subscribe")
      sendy_service.success.should be_truthy
    end
  end
end