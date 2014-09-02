require "spec_helper"

describe Exports::DonationHistory do

  describe '::column_names' do
    it 'should return an array' do
      expect(Exports::DonationHistory.column_names).to be_an_instance_of Array
    end
  end
end