# == Schema Information
#
# Table name: payment_profiles
#
#  id                     :integer          not null, primary key
#  supporter_id           :integer
#  cim_payment_profile_id :string(255)      default("")
#  payment_profile_type   :string(255)      default("")
#  details                :hstore           default({})
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe PaymentProfile do

  payment_profile_attributes = {  supporter_id: 21, cim_payment_profile_id: '32323223', payment_profile_type: 'credit',
                                  cc_last_4: '4342', cc_type: 'visa', cc_month: '10', cc_year: '2017' }

  let(:payment_profile) { FactoryGirl.create(:payment_profile) }

  ## ATTRIBUTES
  describe 'payment profile attribute tests' do
    payment_profile_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end


  ## RELATIONSHIPS
  it { should respond_to(:supporter) }
  it { should respond_to(:payments) }

  
  ## VALIDATIONS
  describe 'payment_profile type validations' do
    it 'should require a payment_profile type' do
      payment_profile.payment_profile_type = ''
      payment_profile.should_not be_valid
    end
  end

  describe 'cc_last_4 validations' do
    it 'should reject bad values' do
      bad_values = %W[abcd abc ab 3 12 12345 123456]
      bad_values.each do |bad_value|
        payment_profile.cc_last_4 = bad_value
        payment_profile.should_not be_valid
      end
    end
    it 'should accept good values' do
      good_values = %W[123 1234 0000]
      good_values.each do |good_value|
        payment_profile.cc_last_4 = good_value
        payment_profile.should be_valid
      end
    end
  end


end
