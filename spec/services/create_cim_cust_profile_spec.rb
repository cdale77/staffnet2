require 'spec_helper'

describe CimCustProfileService do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let(:profile_service) { CimCustProfileService.new(supporter.id, supporter.email_1) }
  describe 'initialize' do
    it 'should create an object' do
      profile_service.should be_an_instance_of CimCustProfileService
    end
  end

  describe '#create' do
    before { profile_service.create }
    it 'should create a profile' do
      profile_service.success.should be_truthy
      profile_service.cim_id.should_not be_blank
    end
  end
end