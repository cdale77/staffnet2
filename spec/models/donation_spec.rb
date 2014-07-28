# == Schema Information
#
# Table name: donations
#
#  id            :integer          not null, primary key
#  legacy_id     :integer
#  supporter_id  :integer
#  shift_id      :integer
#  date          :date
#  donation_type :string(255)      default("")
#  source        :string(255)      default("")
#  campaign      :string(255)      default("")
#  sub_month     :string(1)        default("")
#  sub_week      :integer          default(0)
#  amount        :decimal(8, 2)    default(0.0)
#  cancelled     :boolean          default(FALSE)
#  notes         :text             default("")
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Donation do

  donation_attributes = { date: '2012/12/10', donation_type: 'Ongoing', source: 'Mail', campaign: 'Energy', frequency: 'Monthly',
                          sub_month: 'm', sub_week: 3, amount: 10.00, cancelled: false, notes: 'Notes'}

  let(:donation) { FactoryGirl.create(:donation) }

  ## ATTRIBUTES
  describe 'donation attribute tests' do
    donation_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter) }
  it { should respond_to(:payments) }
  it { should respond_to(:shift) }

  ## VALIDATIONS
  describe 'source validations' do
    it 'should require a source' do
      donation.source = ''
      donation.should_not be_valid
    end
  end

  describe 'date validations' do 
    it 'should require a date' do 
      donation.date = ''
      donation.should_not be_valid
    end
  end

  describe 'sub_month validations' do
    it 'should allow blank values' do
      donation.sub_month = ''
      donation.should be_valid
    end
    it 'should require sub_month to be a single character' do
      donation.sub_month = 'aa'
      donation.should_not be_valid
    end
    it 'should allow correct values' do
      donation.sub_month = 'a'
      donation.should be_valid
    end
  end

  describe 'sub_week validations' do
    it 'should allow blank values' do
      donation.sub_week = ''
      donation.should be_valid
    end
    it 'should require sub_week to be a single integer' do
      invalid_codes = [ 11, 1111, 'a', 'aa']
      invalid_codes.each do |code|
        donation.sub_week = code
        donation.should_not be_valid
      end
    end
    it 'should accept proper values' do
      donation.sub_week = 4
      donation.should be_valid
    end
  end

  ## CLASS METHODS
  describe '::sustaining_donations' do
    before do
      FactoryGirl.create(:donation, sub_week: 3, sub_month: 'm', cancelled: false)
      FactoryGirl.create(:donation, sub_week: 3, sub_month: 'm', cancelled: false)
      FactoryGirl.create(:donation, sub_week: 3, sub_month: 'm', cancelled: true)
      FactoryGirl.create(:donation, sub_week: 0, sub_month: '', cancelled: false)
    end
    it 'should return the sustaining donations' do
      expect(Donation.sustaining_donations.count).to eq 2
    end
  end

  ## INSTANCE METHODS
  describe '#is_sustainer?' do
    it 'should return the correct result for a sustainer' do
      donation.sub_month = 'm'
      donation.sub_week = 2
      donation.cancelled = false
      expect(donation.is_sustainer?).to be_true
    end
    it 'should return the correct result for a non sustainer' do
      donation.sub_week = ''
      expect(donation.is_sustainer?).to be_false
    end
    it 'should return the correct result for a cancelled sustainer do' do
      donation.cancelled = true
      expect(donation.is_sustainer?).to be_false
    end

  end
end
