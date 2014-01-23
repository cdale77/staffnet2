require 'spec_helper'

describe Cim::Profile do 

  let!(:test_id) { 122232 }

  let!(:profile) { Cim::Profile.new(test_id) }

  #after { profile.unstore }

  describe '#initialize' do 
    it 'should create an object' do
      profile.should be_an_instance_of Cim::Profile
    end
  end

  describe '#store' do 
    it 'should store a profile' do 
      profile.store.should be_an_instance_of String
     # profile.cim_id.should eq test_id
    end

  end
  
end