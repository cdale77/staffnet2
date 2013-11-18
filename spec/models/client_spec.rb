# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("")
#  address1      :string(255)      default("")
#  address2      :string(255)      default("")
#  city          :string(255)      default("")
#  state         :string(255)      default("")
#  zip           :string(255)      default("")
#  contact_name  :string(255)      default("")
#  contact_phone :string(255)      default("")
#  contact_email :string(255)      default("")
#  uri           :string(255)      default("")
#  notes         :text             default("")
#

require 'spec_helper'

describe Client do

  client_attributes = { name: 'Acme Co', address1: '2345 College Ave', address2: 'Ste. 200', city: 'Oakland', state: 'CA',
                        zip: '94609', uri: 'http://www.example.com', contact_name: 'Some Person',
                        contact_phone: '5108459321', contact_email: 'acme@example.com', notes: 'Great client.' }

  let(:client) { FactoryGirl.create(:client) }

  subject { client }

  ## ATTRIBUTES
  describe 'client attribute tests' do
    client_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end
end
