# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  supporter_type_id :integer
#  sendy_list_id     :integer
#  legacy_id         :string(255)      default("")
#  external_id       :string(255)      default("")
#  cim_id            :string(255)      default("")
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
#  address_county    :string(255)      default("")
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
#  employer          :string(255)      default("")
#  occupation        :string(255)      default("")
#  source            :string(255)      default("")
#  notes             :text             default("")
#  sendy_status      :string(255)      default("")
#  sendy_updated_at  :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  cim_customer_id   :string(255)      default("")
#  vol_level         :string(255)      default("")
#  spouse_name       :string(255)      default("")
#  prospect_group    :string(255)      default("")
#

require 'spec_helper'

describe Supporter do

  supporter_attributes = {  external_id: "3421",
                            cim_id: "43300134",
                            supporter_type_id: 1,
                            prefix: "Mr.",
                            salutation: "Bob",
                            first_name: "William",
                            last_name: "Taft",
                            suffix: "III",
                            address1: "44 Winter Street",
                            address2: "2nd Floor",
                            address_city: "Boston",
                            address_state: "MA",
                            address_zip: "02010",
                            email_1: "bob@example.com",
                            email_2: "bobtaft@example.com",
                            phone_mobile: "5554859875",
                            phone_home: "5559007845",
                            phone_alt: "5558874952",
                            keep_informed: true,
                            vol_level: "prospect",
                            employer: "Ohio State University",
                            occupation: "Professor",
                            source: "door",
                            notes: "Note.",
                            sendy_updated_at: Time.now,
                            sendy_status: "subscribed",
                            sendy_list_id: 3,
                            address_county: "Alameda",
                            cim_customer_id: "100024",
                            spouse_name: "John",
                            prospect_group: "c" }

  # eager-eval to limit Cim callbacks
  let!(:supporter_type) { FactoryGirl.create(:supporter_type,
                                              name: "supporter") }
  let!(:supporter) { FactoryGirl.create(:supporter) }
  let!(:sustainer) { FactoryGirl.create(:supporter) }
  let!(:donation) { FactoryGirl.create(:donation,
                                       amount: 10,
                                       supporter: sustainer,
                                       sub_month: 'm',
                                       sub_week: 3) }
  subject { supporter }

  ## ATTRIBUTES
  describe 'supporter attribute tests' do
    supporter_attributes.each do |key, value|
      it { should respond_to(key)}
    end
  end

  describe 'tagging atribute' do
    it {should respond_to(:tag_list) }
  end

  ## RELATIONSHIPS
  it { should respond_to(:supporter_type) }
  it { should respond_to(:donations) }
  it { should respond_to(:payments) }
  it { should respond_to(:payment_profiles) }
  it { should respond_to(:sendy_list) }
  it { should respond_to(:taggings) }
  it { should respond_to(:tags) }


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

  ## CLASS METHODS
  describe '::current_sustainers' do
    it 'should return the current sustainers' do
      current_sustainers = Supporter.current_sustainers
      expect(current_sustainers.first).to eql sustainer
    end
  end

  ## METHODS
  describe '#supporter_type_name' do
    it 'should return the supporter type name' do
      expect(supporter.supporter_type_name).to eq "supporter"
    end
  end
  describe '#donations_amount' do
    it 'should return the correct donations amount with multiplier' do
      expect(sustainer.donations_amount).to eq 70
    end
  end
  describe '#donations_count' do
    it 'should return the correct donations count' do
      expect(sustainer.donations_count).to eq 1
    end
  end
  describe 'salutation setting' do
    it 'should set the salutation correctly' do
      name = 'Kim'
      supporter.salutation = ''
      supporter.first_name = name
      supporter.save
      expect(supporter.reload.salutation).to eql name
    end
  end
  describe 'email downcasing' do
    it 'should downcase emails' do
      email = 'UPPERCASEEMAIL@gmail.com'
      supporter.email_1 = email
      supporter.save
      expect(supporter.reload.email_1).to eql email.downcase
    end
  end
  describe 'phone number cleaning' do
    it 'should clean junk from phone numbers' do
      dirty_phone = '415-555-1234'
      clean_phone = '4155551234'
      supporter.phone_mobile = dirty_phone
      supporter.save
      expect(supporter.reload.phone_mobile).to eql clean_phone
    end
  end
  describe '#is_sustainer?' do
    it 'should return true if the supporter has a sustaining donation' do
      expect(sustainer.is_sustainer?).to be_truthy
    end
    it 'should return false if the supporter does not have a sustaining donation' do
      expect(supporter.is_sustainer?).to be_falsey
    end
  end

  ## CIM
  describe 'Cim customer id' do
    before { supporter.generate_cim_customer_id }
    it '#generated_cim_customer_id' do
      expect(supporter.cim_customer_id).to eq (supporter.id + 20000).to_s
    end

  end
end
