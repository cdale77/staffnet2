require 'spec_helper'

describe Donation do

  donation_attributes = { date: '2012/12/10', donation_type: 'Ongoing', source: 'Mail', campaign: 'Energy',
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
end