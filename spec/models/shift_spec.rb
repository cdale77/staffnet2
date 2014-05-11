# == Schema Information
#
# Table name: shifts
#
#  id                        :integer          not null, primary key
#  employee_id               :integer
#  field_manager_employee_id :integer
#  shift_type_id             :integer
#  legacy_id                 :string(255)      default("")
#  date                      :date
#  time_in                   :time
#  time_out                  :time
#  break_time                :integer          default(0)
#  notes                     :text             default("")
#  travel_reimb              :decimal(8, 2)    default(0.0)
#  cv_shift                  :boolean          default(FALSE)
#  quota_shift               :boolean          default(FALSE)
#  products                  :hstore           default({})
#  reported_raised           :decimal(8, 2)    default(0.0)
#  reported_total_yes        :integer          default(0)
#  reported_cash_qty         :integer          default(0)
#  reported_cash_amt         :decimal(8, 2)    default(0.0)
#  reported_check_qty        :integer          default(0)
#  reported_check_amt        :decimal(8, 2)    default(0.0)
#  reported_one_time_cc_qty  :integer          default(0)
#  reported_one_time_cc_amt  :decimal(8, 2)    default(0.0)
#  reported_monthly_cc_qty   :integer          default(0)
#  reported_monthly_cc_amt   :decimal(8, 2)    default(0.0)
#  reported_quarterly_cc_amt :integer          default(0)
#  reported_quarterly_cc_qty :decimal(8, 2)    default(0.0)
#  created_at                :datetime
#  updated_at                :datetime
#

require 'spec_helper'

describe Shift do

  shift_attributes = {  date: Date.today, time_in: Time.now - 4.hours, time_out: Time.now,
                        break_time: 30, notes: 'Great shift', travel_reimb: 12.50, legacy_id: '56', cv_shift: true,
                        quota_shift: true, reported_raised: 335, reported_cash_qty: 2, reported_cash_amt: 25,
                        reported_check_qty: 1, reported_check_amt: 100, reported_one_time_cc_qty: 1,
                        reported_one_time_cc_amt: 50, reported_monthly_cc_qty: 1, reported_monthly_cc_amt: 10,
                        reported_quarterly_cc_qty: 2, reported_quarterly_cc_amt: 30, reported_total_yes: 7 }


  let(:shift) { FactoryGirl.create(:shift) }

  subject { shift }

  ## ATTRIBUTES
  describe 'shift attribute tests' do
    shift_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:user) }
  it { should respond_to(:shift_type) }
  it { should respond_to(:employee) }
  it { should respond_to(:donations) }
  it { should respond_to(:payments) }
  #it { should respond_to(:tasks) }

  ## VALIDATIONS
  describe 'date validations' do
    it 'should require a date' do
      shift.date = ''
      shift.should_not be_valid
    end
  end

  describe 'break time validations' do
    it 'should reject negative values' do
      negative_break = -9
      shift.break_time = negative_break
      shift.should_not be_valid
    end
    it 'should reject too high break times' do
      large_break = 121
      shift.break_time = large_break
      shift.should_not be_valid
    end
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

    describe 'reported_raised validations' do
      it 'should require reported_raised to match the sub amounts' do
        shift.reported_raised = 10
        shift.should_not be_valid
      end
    end

    describe 'total raised validations' do
      it 'should require total yes to equal itemized amounts' do
        shift.reported_total_yes = 0
        shift.should_not be_valid
      end
      it 'should require total raised to equal itemized amounts' do
        shift.reported_raised = 0
        shift.should_not be_valid
      end
    end
  end

  ## METHODS
  describe 'net_time method' do
    it 'should have a net time method' do
      shift.time_in = Time.now.beginning_of_day
      shift.time_out = Time.now.beginning_of_day + 5.hours
      shift.break_time = 30
      shift.net_time.should eql 4.5
    end
  end
end
