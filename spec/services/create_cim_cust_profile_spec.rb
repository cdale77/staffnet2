require 'spec_helper'

describe CimCustProfileService do

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let(:profile_service) { CimCustProfileService.new(supporter.id, supporter.email_1) }
  describe 'initialize' do
    it 'should create an object' do
      profile_service.should be_an_instance_of CimCustProfileService
    end
  end


end