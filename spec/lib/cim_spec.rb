require 'spec_helper'

describe Cim::Profile do 

  let!(:test_id) { 122232 }
  let!(:profile) { Cim::Profile.new(test_id) }

  describe '#initialize' do 
    it 'should create an object' do
      profile.should be_an_instance_of Cim::Profile
    end
  end

  describe '#store' do 
    it 'should store a profile' do 
      profile.store.should be_an_instance_of String  #store returns a string (cim id) if successful, false if not successful.
    end
  end
end

describe Cim::PaymentProfile do

  #let(:supporter) { FactoryGirl.create(:supporter) }
  #let!(:payment_profile) { Cim::PaymentProfile.new(supporter, ) }

  describe '#initialize' do
    it 'should create an object' do

    end

  end
end