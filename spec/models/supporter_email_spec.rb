# == Schema Information
#
# Table name: supporter_emails
#
#  id           :integer          not null, primary key
#  supporter_id :integer
#  employee_id  :integer
#  donation_id  :integer
#  email_type   :string(255)      default("")
#  body         :text             default("")
#  success      :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe SupporterEmail do

  supporter_email_attributes = { body: 'An email', email_type: 'receipt', success: true }

  let(:supporter) { FactoryGirl.create(:supporter) }
  let(:donation) { FactoryGirl.create(:donation, supporter_id: supporter.id) }
  let(:employee) { FactoryGirl.create(:employee) }
  let(:supporter_email) { FactoryGirl.create(:supporter_email, supporter_id: supporter.id, donation_id: donation.id) }
  subject { supporter_email }

  ## ATTRIBUTES
  describe 'supporter_email attribute tests' do
    supporter_email_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter) }
  it { should respond_to(:employee) }
end
