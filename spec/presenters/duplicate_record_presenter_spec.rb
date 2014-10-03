require "spec_helper"


describe DuplicateRecordPresenter do 
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:dupe_supporter) { FactoryGirl.create(:supporter) }

  let!(:duplicate_record) { DuplicateRecord.create!(
                                record_type_name: "supporter",
                                first_record_id: supporter.id,
                                additional_record_ids: [dupe_supporter.id]) }

  let!(:presenter) { DuplicateRecordPresenter.new(duplicate_record) }
  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of DuplicateRecordPresenter
    end
  end

  describe '#first_record' do
    it 'should return the primary supporter' do
      expect(presenter.first_record).to eq supporter
    end
  end

  describe '#secondrecord' do 
    it 'should return the duplicate record' do 
      expect(presenter.second_record).to eq dupe_supporter
    end
  end

  describe '#klass' do 
    it 'should return the class of the dupe objects' do 
      expect(presenter.klass).to eq Supporter
    end
  end

end
