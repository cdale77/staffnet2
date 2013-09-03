# == Schema Information
#
# Table name: shifts
#
#  id            :integer          not null, primary key
#  employee_id   :integer
#  shift_type_id :integer
#  date          :date
#  time_in       :time
#  time_out      :time
#  break_time    :integer          default(0)
#  notes         :string(255)      default("")
#  travel_reimb  :decimal(8, 2)    default(0.0)
#  created_at    :datetime
#  updated_at    :datetime
#

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

  ## RELATIONSHIPS
  it { should respond_to(:shift_type) }
  it { should respond_to(:employee) }

  ## VALIDATIONS
  describe 'break time validations' do
    it 'should reject too high break times' do
      large_break = 121
      shift.break_time = large_break
      shift.should_not be_valid
    end
    it 'should reject too short break times' do
      short_break = 4
      shift.break_time = short_break
      shift.should_not be_valid
    end
  end
end
