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
  it { should respond_to(:user) }
  it { should respond_to(:shift_type) }
  it { should respond_to(:employee) }

  ## VALIDATIONS
  describe 'date validations' do
    it 'should require a date' do
      shift.date = ''
      shift.should_not be_valid
    end
  end

  describe 'break time validations' do
    it 'should reject too high break times' do
      large_break = 121
      shift.break_time = large_break
      shift.should_not be_valid
    end

    #using the numericality validator for this seems to reject break times of 0. Comment out for now. 13-9-11
    #it 'should reject too short break times' do
    #  short_break = 4
    #  shift.break_time = short_break
    #  shift.should_not be_valid
    #end
  end

  describe 'travel reimb validations' do
    it 'should reject negative values' do
      negative_reimb = -9
      shift.travel_reimb = negative_reimb
      shift.should_not be_valid
    end
  end

  describe 'shift length validations' do
    it 'should require a minimum shift length' do
      shift.time_in = Time.now - 1.hour
      shift.time_out = Time.now
      shift.should_not be_valid
    end
    it 'should require a maximum shift length' do
      shift.time_in = Time.now - 25.hours
      shift.time_out = Time.now
    end

    describe 'travel_reimb validations' do
      it 'should reject too large travel reimbursements' do
        shift.travel_reimb = 101
        shift.should_not be_valid
      end
    end
  end
end
