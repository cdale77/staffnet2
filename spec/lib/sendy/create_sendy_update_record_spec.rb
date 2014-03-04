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

  describe '::subscribe failure' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.subscribe('not_an_id').should be_false
    end
    it 'should not create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.subscribe('not_an_id') }.to_not change(SendyUpdate, :count)
    end
  end

  describe '::unsubscribe success' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.unsubscribe(supporter.id).should be_true
    end
    it 'should create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.unsubscribe(supporter.id) }.to change(SendyUpdate, :count).by(1)
    end
  end

  describe '::unsubscribe failure' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.unsubscribe('not_an_id').should be_false
    end
    it 'should not create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.unsubscribe('not_an_id') }.to_not change(SendyUpdate, :count)
    end
  end

  describe '::update success' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.update(supporter.id, 'update').should be_true
    end
    it 'should create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.update(supporter.id, 'update') }.to change(SendyUpdate, :count).by(1)
    end
  end

  describe '::update failure' do
    it 'should return true on success' do
      CreateSendyUpdateRecord.update('not_an_id', 'update').should be_false
    end
    it 'should not create a Sendy Update record' do
      expect { CreateSendyUpdateRecord.update('not_an_id', 'update') }.to_not change(SendyUpdate, :count)
    end
  end
end