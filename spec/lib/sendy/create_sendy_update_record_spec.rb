require 'spec_helper'

describe CreateSendyUpdateRecord do

  let!(:sendy_list) { FactoryGirl.create(:sendy_list)}
  let!(:supporter) { FactoryGirl.create(:supporter, sendy_list_id: sendy_list.id) }

  describe '::subscribe success' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.subscribe(supporter.id).should be_true
    end
    it 'should create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.subscribe(supporter.id) }.to change(SendyUpdate, :count).by(1)
    end
  end
end