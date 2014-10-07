require "spec_helper"

describe ResolveDuplicateRecordsService do 

  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:dupe) { FactoryGirl.create(:supporter) }
  let!(:dupe_donation) { FactoryGirl.create(:donation, supporter: dupe)}
  let!(:dupe_record) { DuplicateRecord.create(
                        first_record_id: supporter.id,
                        additional_record_ids: [dupe.id])}
  let!(:payload) { SpecData.resolve_dupe_payload(supporter.id, 
                                                  dupe.id,
                                                  dupe_record.id) }
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
    it 'should mark the dupe record as resolved' do 
      expect(dupe_record.reload.resolved).to be true
    end
  end
end
