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
#  paycheck_id               :integer
#  site                      :string(255)      default("")
#

require 'spec_helper'

describe Shift do

  shift_attributes = SpecData.shift_attributes


  let!(:shift_type) { FactoryGirl.create(:shift_type) }
  let!(:shift) { FactoryGirl.create(:shift,
                                    shift_type: shift_type) }
  let!(:donation) { FactoryGirl.create(:donation,
                                        amount: 10,
                                        donation_type: "cash",
                                        shift: shift) }
  let!(:donation2) { FactoryGirl.create(:donation,
                                         amount: 10,
                                         donation_type: "credit",
                                         sub_week: 1,
                                         sub_month: "m",
                                         shift: shift) }
  let!(:payment) { FactoryGirl.create(:payment,
                                       amount: 10,
                                       captured: true,
                                       donation: donation) }
  let!(:payment2) { FactoryGirl.create(:payment,
                                        amount: 10,
                                        captured: true,
                                        donation: donation2) }
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
  it { should respond_to(:paycheck) }

  ## DELEGATED METHODS
  it { should respond_to(:shift_type_name) }
  it { should respond_to(:fundraising_shift) }
  it { should respond_to(:quota_shift) }
  it { should respond_to(:workers_comp_type) }

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
  describe '#captured_donations' do
    it 'should return an array' do
      expect(shift.captured_donations).to be_an_instance_of Array
    end
    it 'should return two donations' do
      expect(shift.captured_donations.count).to eq 2
    end
  end
  describe '#total_deposit' do
    it 'should return the deposit total for associated donations' do
      shift.total_deposit.should eq 20
    end
  end
  describe '#total_fundraising_credit' do
    it 'should return the total fundraising credit' do
      shift.gross_fundraising_credit.should eq 80
    end
  end
  describe '#net_time' do
    it 'should have a net time method' do
      shift.time_in = Time.now.beginning_of_day
      shift.time_out = Time.now.beginning_of_day + 5.hours
      shift.break_time = 30
      shift.net_time.should eql 4.5
    end
  end
end
