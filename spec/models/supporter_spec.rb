# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  external_id       :integer
#  cim_id            :integer
#  supporter_type_id :integer
#  prefix            :string(255)      default("")
#  salutation        :string(255)      default("")
#  first_name        :string(255)      default("")
#  last_name         :string(255)      default("")
#  suffix            :string(255)      default("")
#  address1          :string(255)      default("")
#  address2          :string(255)      default("")
#  address_city      :string(255)      default("")
#  address_state     :string(255)      default("")
#  address_zip       :string(255)      default("")
#  address_bad       :boolean          default(FALSE)
#  email_1           :string(255)      default("")
#  email_1_bad       :boolean          default(FALSE)
#  email_2           :string(255)      default("")
#  email_2_bad       :boolean          default(FALSE)
#  phone_mobile      :string(255)      default("")
#  phone_mobile_bad  :boolean          default(FALSE)
#  phone_home        :string(255)      default("")
#  phone_home_bad    :boolean          default(FALSE)
#  phone_alt         :string(255)      default("")
#  phone_alt_bad     :boolean          default(FALSE)
#  do_not_mail       :boolean          default(FALSE)
#  do_not_call       :boolean          default(FALSE)
#  do_not_email      :boolean          default(FALSE)
#  keep_informed     :boolean          default(FALSE)
#  vol_level         :integer          default(0)
#  employer          :string(255)      default("")
#  occupation        :string(255)      default("")
#  source            :string(255)      default("")
#  notes             :string(255)      default("")
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Supporter do

  supporter_attributes = {  external_id: 3421, cim_id: 43300134, supporter_type_id: 1, prefix: 'Mr.', salutation: 'Bob',
                            first_name: 'William', last_name: 'Taft', suffix: 'III', address1: '44 Winter Street',
                            address2: '2nd Floor', address_city: 'Boston', address_state: 'MA', address_zip: '02010',
                            email_1: 'bob@example.com', email_2: 'bobtaft@example.com', phone_mobile: '5554859875',
                            phone_home: '5559007845', phone_alt: '5558874952', keep_informed: true, vol_level: 'prospect',
                            employer: 'Ohio State University', occupation: 'Professor', source: 'door', notes: 'Note.' }

  let(:supporter) { FactoryGirl.create(:supporter) }

  ## ATTRIBUTES
  describe 'supporter attribute tests' do
    supporter_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter_type) }
  #it { should respond_to(:donations) }
  #it { should respond_to(:payments) }

  ## VALIDATIONS
  describe 'prefix validations' do 
    it 'should reject too long prefixes' do 
      supporter.prefix = 'a' * 26
      supporter.should_not be_valid
    end
  end
  describe 'salutation validations' do 
    it 'should reject too long salutations' do 
      supporter.salutation = 'a' * 26
      supporter.should_not be_valid
    end
  end
  describe 'first name validations' do
    it 'should reject supporters with too long first names' do
      long_name = 'a' * 26
      supporter.first_name = long_name
      supporter.should_not be_valid
    end
    it 'should reject supporters with too short first names' do
      short_name = 'a'
      supporter.first_name = short_name
      supporter.should_not be_valid
    end
  end
  describe 'last name validations' do
    it 'should reject supporters with no last name' do
      supporter.last_name = ''
      supporter.should_not be_valid
    end
    it 'should reject supporters with too long last names' do
      long_name = 'a' * 36
      supporter.last_name = long_name
      supporter.should_not be_valid
    end
    it 'should reject supporters with too short last names' do
      short_name = 'a'
      supporter.last_name = short_name
      supporter.should_not be_valid
    end
  end
  describe 'state validations' do
    it 'should require states to be alpha' do
      supporter.address_state = '4'
      supporter.should_not be_valid
    end
    it 'should require states to be 2 capital letters' do
      invalid_states = %w[A AAA aa aaa A4 3 3A]
      invalid_states.each do |invalid_state|
        supporter.address_state = invalid_state
        supporter.should_not be_valid
      end
    end
  end
  describe 'zip validation' do
    it 'should require zip to be 5 digits' do
      bad_zips = %w[1 123 1234 123456 asbcd %$#@% ]
      bad_zips.each do |bad_zip|
        supporter.address_zip = bad_zip
        supporter.should_not be_valid
      end
    end
  end
  describe 'email validations' do
    it 'should reject invalid emails' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        supporter.email_1 = invalid_address
        supporter.should_not be_valid
      end
    end
    it 'should accept valid emails' do
      addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.com]
      addresses.each do |valid_address|
        supporter.email_1 = valid_address
        supporter.should be_valid
      end
    end
  end
  describe 'phone number validations' do
    it 'should reject employees with an invalid phone number' do
      bad_phones = %W[1 123456789 ]
      bad_phones.each do |bad_phone|
        supporter.phone_mobile = bad_phone
        supporter.should_not be_valid
      end
    end
  end

  ## METHODS

  describe 'salutation setting' do
    it 'should set the salutation correctly' do
      name = 'Kim'
      supporter.salutation = ''
      supporter.first_name = name
      supporter.save
      expect(supporter.reload.salutation).to eql name
    end
  end
end
