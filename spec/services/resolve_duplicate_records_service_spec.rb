require "spec_helper"

describe ResolveDuplicateRecordsService do 

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:dupe) { FactoryGirl.create(:supporter) }
  let!(:dupe_donation) { FactoryGirl.create(:donation, supporter: dupe)}
  let!(:payload) { SpecData.resolve_dupe_payload(supporter.id, dupe.id) }
  let!(:service) { ResolveDuplicateRecordsService.new(payload) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of ResolveDuplicateRecordsService
    end
  end

  describe '#perform' do 
    before { service.perform }
    it 'should merge the records' do 
      expect(supporter.reload.address_state).to eq "NY"
    end
    it 'should merge the donation' do 
      expect(dupe_donation.reload.supporter).to eq supporter
    end
  end
end
