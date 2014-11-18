require "spec_helper"
include ActionView::Helpers::NumberHelper

describe SupporterPresenter do

  let!(:supporter_type) { FactoryGirl.create(:supporter_type) }
  let!(:supporter) { FactoryGirl.create(:supporter,
                                         supporter_type: supporter_type) }
  let!(:presenter) { SupporterPresenter.new(supporter) }

  describe '#initialize' do
    it 'should create an object' do
      expect(presenter).to be_an_instance_of SupporterPresenter
    end
  end

  describe '#model' do
    it 'should return the original object' do
      expect(presenter.model).to be_an_instance_of Supporter
    end
  end

  describe '#formatted_city_state_zip' do
    it 'should return an address line' do
      expect(presenter.formatted_city_state_zip).to eq \
      "#{supporter.address_city}, #{supporter.address_state} " \
      "#{supporter.address_zip}"
    end
  end

  describe '#occupation_to_human' do
    it 'should humanize the occupation' do
      expect(presenter.occupation_to_human).to eq supporter.occupation.humanize
    end
  end

  describe '#source_to_human' do
    it 'should humanize the source' do
      expect(presenter.source_to_human).to eq supporter.source.humanize
    end
  end

  describe '#phone_mobile_to_human' do
    it 'should humanize the source' do
      expect(presenter.phone_mobile_to_human).to eq \
        number_to_phone(supporter.phone_mobile.to_i)
    end
  end

  describe '#supporter_type_name' do
    it 'should humanize the supporter type name' do
      expect(presenter.supporter_type_name).to eq supporter_type.name.humanize
    end
  end

  describe '#formatted_sendy_status' do 
    it 'should humanize the sendy status' do 
      expect(presenter.formatted_sendy_status).to eq \
        "#{supporter.sendy_status.humanize}d"
    end
  end
end

