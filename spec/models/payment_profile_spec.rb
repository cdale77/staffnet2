# == Schema Information
#
# Table name: payment_profiles
#
#  id                     :integer          not null, primary key
#  supporter_id           :integer
#  cim_payment_profile_id :string(255)      default("")
#  payment_profile_type   :string(255)      default("")
#  details                :hstore           default("")
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe PaymentProfile do

  payment_profile_attributes = {  supporter_id: 21, cim_payment_profile_id: '32323223', payment_profile_type: 'credit',
                                  cc_last_4: '1111', cc_type: 'visa', cc_month: '10', cc_year: '2017',
                                  cc_number: '4111111111111111'}

  let!(:payment_profile) { FactoryGirl.create(:payment_profile) } # eager-eval to limit Cim callbacks

  ## ATTRIBUTES
  describe 'payment profile attribute tests' do
    payment_profile_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter) }
  it { should respond_to(:payments) }

  ## CALLBACKS
  describe 'saving cc info' do
    it 'should save the last 4 cc numbers' do
      payment_profile.cc_number = '4111111111155555'
      payment_profile.save
      payment_profile.reload.cc_last_4.should eql '5555'
    end
  end

  describe 'saving the cc type' do
    it 'should save the correct cc type' do
      payment_profile.cc_number = '5111111111111111'
      payment_profile.save
      payment_profile.reload.cc_type.should eql 'mc'
    end
  end

  
  ## VALIDATIONS
  describe 'payment_profile type validations' do
    it 'should require a payment_profile type' do
      payment_profile.payment_profile_type = ''
      payment_profile.should_not be_valid
    end
  end
end
