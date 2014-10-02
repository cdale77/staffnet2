require "spec_helper"


describe DuplicateRecordPresenter do 
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:dupe_supporter) { FactoryGirl.create(:supporter) }

  let!(:duplicate_record) { DuplicateRecord.create!(
                                record_type: "supporter",
                                primary_record_id: supporter.id,
                                duplicate_record_ids: [dupe_supporter.id]) }

  let!(:presenter) { DuplicateRecordPresenter.new(duplicate_record) }
  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of DuplicateRecordPresenter
    end
  end

  describe '#primary_record' do
    it 'should return the primary supporter' do
      expect(presenter.model).to eq supporter
    end
  end

end
