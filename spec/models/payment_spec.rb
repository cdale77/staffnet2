# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  cim_profile_id     :string(255)      default("")
#  cim_transaction_id :string(255)      default("")
#  user_id            :integer
#  processed          :date
#  payment_type       :string(255)      default("")
#  capture            :boolean          default(FALSE)
#  amount             :decimal(8, 2)    default(0.0)
#  cc_last_4          :string(4)        default("")
#  cc_month           :string(2)        default("")
#  cc_year            :string(4)        default("")
#  cc_type            :string(255)      default("")
#  check_number       :string(255)      default("")
#

require 'spec_helper'

describe Payment do

  payment_attributes = { processed: Time.now, payment_type: 'Credit Card', captured: true, amount: 10.00,
                         cim_profile_id: '322134421', cc_last_4: '4321', cc_type: 'Visa', cc_month: '02',
                         cc_year: '2014', check_number: '2122', user_id: 43, cim_transaction_id: '344442211113',
                         notes: 'Notes'}

  let(:payment) { FactoryGirl.create(:payment) }

  ## ATTRIBUTES
  describe 'payment attribute tests' do
    payment_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:donation) }
end
