require 'spec_helper'

describe Cim do

  let!(:supporter) { FactoryGirl.create(:supporter) }

  before { supporter.unstore_cim_profile }

  describe Cim::Profile do

    let!(:profile) { Cim::Profile.new(supporter.id) }

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

    let!(:supporter) { FactoryGirl.create(:supporter) }
    let!(:payment_profile) { Cim::PaymentProfile.new(supporter, '4111111111111111', '10', '2017', 'visa') }

    describe '#initialize' do
      it 'should create an object' do
        payment_profile.should be_an_instance_of Cim::PaymentProfile
      end
    end

    describe '#store' do
      it 'should store a payment profile' do
        payment_profile.store.should be_an_instance_of String  #store returns a string (cim id) if successful, false if not successful.
      end
    end
  end
end



