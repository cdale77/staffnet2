require "spec_helper"

describe ResolveDuplicateRecordsService do 

  
  
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:dupe) { FactoryGirl.create(:supporter) }
  let!(:payload) { SpecData.resolve_dupe_payload(supporter.id, dupe.id) }
  let(:service) { ResolveDuplicateRecordsService.new(payload) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of ResolveDuplicateRecordsService
    end
  end
end
