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

  donation_attributes = { date: '2012/12/10', donation_type: 'Ongoing', source: 'Mail', campaign: 'Energy', frequency: 'One time',
                          sub_month: 'a', sub_week: 3, amount: 10.00, cancelled: false, notes: 'Notes'}

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
end
