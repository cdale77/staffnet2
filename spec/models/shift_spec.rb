require 'spec_helper'

describe Shift do

  shift_attributes = {  date: Date.today, time_in: Time.now - 4.hours, time_out: Time.now,
                        break_time: 30, notes: 'Great shift', travel_reimb: 12.50 }


  let(:shift) { FactoryGirl.create(:shift) }

  subject { shift }

  ## ATTRIBUTES
  describe 'shift atribute tests' do
    shift_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## VALIDATIONS

  describe 'shift type validations' do

  end
end