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

  payment_profile_attributes = { supporter_id: 21, cim_payment_profile_id: '32323223', payment_profile_type: 'credit' }

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

end
