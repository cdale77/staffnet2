require "spec_helper"

describe ValidateDuplicateRecordService do

  let!(:supporter1) { FactoryGirl.create(:supporter) }
  let!(:supporter2) { FactoryGirl.create(:supporter) }
  let!(:supporter3) { FactoryGirl.create(:supporter) }

  let!(:dupe_record) { DuplicateRecord.new }
  let!(:service) { ValidateDuplicateRecordService.new(dupe_record) }

  describe '#initialize' do
    it 'should create an object' do
      service.should be_an_instance_of ValidateDuplicateRecordService
    end
  end

  describe '#valid?' do
    it 'should return false' do
      expect(service.valid?).to be_falsy
    end
    it 'should return false when the additional records array is empty' do
      dupe_record.first_record_id = supporter1.id
      expect(service.valid?).to be_falsey
    end
    it 'should return false if it cannot find a particular supporter' do
      dupe_record.additional_record_ids = [supporter2.id, supporter3.id, 333223]
      expect(service.valid?).to be_falsey
    end
    it 'should return false if the first id is in the additional array' do
      dupe_record.additional_record_ids = [supporter2.id, supporter3.id, supporter1.id]
      expect(service.valid?).to be_falsey
    end
    it 'shoud return true' do
      dupe_record.additional_record_ids = [supporter2.id, supporter3.id]
    end
  end

end

