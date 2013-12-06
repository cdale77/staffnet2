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
#  created_at    :datetime
#  updated_at    :datetime
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

  ## RELATIONSHIPS
  #it { should respond_to(:projects) }

  ## VALIDATIONS
  describe 'name validations' do
    it 'should reject clients with no name' do
      client.name = ''
      client.should_not be_valid
    end
  end

  describe 'state validations' do
    it 'should allow blank states' do
      client.state = ''
      client.should be_valid
    end
    it 'should require state to be two upper case characters' do
      invalid_states = %w[A AAA aa aaa A4 3 3A 33]
      invalid_states.each do |invalid_state|
        client.state = invalid_state
        client.should_not be_valid
      end
    end
  end

  describe 'contact phone validations' do
    it 'should allow blank contact phones' do
      client.contact_phone = ''
      client.should be_valid
    end
    it 'should require contact phone numbers to be 10 digits only' do
      bad_phones = %W[1 123456789]
      bad_phones.each do |bad_phone|
        client.contact_phone = bad_phone
        client.should_not be_valid
      end
    end
  end

  describe 'contact email validations' do
    it 'should allow blank contact emails' do
      client.contact_email = ''
      client.should be_valid
    end
    it 'should reject invalid emails' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz_com foo@barcom]
      addresses.each do |invalid_address|
        client.contact_email = invalid_address
        client.should_not be_valid
      end
    end
    it 'should accept valid emails' do
      addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.com]
      addresses.each do |valid_address|
        client.contact_email = valid_address
        client.should be_valid
      end
    end
  end

  describe 'uri validations' do
    it 'should allow blank uri fields' do
      client.uri = ''
      client.should be_valid
    end
    #it 'should reject invalid uris' do
    #  bad_uris = %W[http/ somestring .com htt://wwww.somestring.com www.example.com ]
    #  bad_uris.each do |bad_uri|
    #    client.uri = bad_uri
    #    client.should_not be_valid
    #  end
    #end
    #it 'should accept valid uris' do
    #  valid_uris = %W[http://www.example.com https://www.example.com http://www.example.org ]
    #  valid_uris.each do |valid_uri|
    #    client.uri = valid_uri
    #    client.should be_valid
    #  end
    #end
  end
end
