require 'spec_helper'

describe SupporterService do
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:sendy_list) { FactoryGirl.create(:sendy_list) }
  let(:supporter_service) { SupporterService.new(supporter, sendy_list.id, supporter.email_1) }
  describe '#initialize' do
    it 'should create an object' do
      supporter_service.should be_an_instance_of SupporterService
    end
  end

  describe '#new_supporter' do
    before { supporter_service.new_supporter }
    it 'should be successful' do
      supporter_service.success.should be_true
    end
  end

  describe '#destroy_supporter' do
    before do
      supporter_service.new_supporter
      supporter_service.destroy_supporter
    end
    it 'should be successful' do
      supporter_service.success.should be_true
    end
  end

  describe '#update_supporter' do
    before { supporter_service.update_supporter }
    it 'should be successful' do
      supporter_service.success.should be_true
    end
  end
end