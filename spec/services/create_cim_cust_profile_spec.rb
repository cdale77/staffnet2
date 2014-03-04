require 'spec_helper'

describe CimCustProfileService do

  let(:supporter) { FactoryGirl.create(:supporter) }

  describe '::create' do
    describe 'success' do
      it 'should return a cim profile id' do
        result = CimCustProfileService.create(supporter.id, supporter.email_1)
        result.should be_an_instance_of String
      end
    end
  end
end