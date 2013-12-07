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
#  address_line_1    :string(255)      default("")
#  address_line_2    :string(255)      default("")
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
                            first_name: 'William', last_name: 'Taft', suffix: 'III', address_line_1: '44 Winter Street',
                            address_line_2: '2nd Floor', address_city: 'Boston', address_state: 'MA', address_zip: '02010',
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
  it { should respond_to(:contact_type) }
  #it { should respond_to(:donations) }
  #it { should respond_to(:payments) }

  ## VALIDATIONS

end
