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
#  address_bad       :boolean          default("false")
#  email_1           :string(255)      default("")
#  email_1_bad       :boolean          default("false")
#  email_2           :string(255)      default("")
#  email_2_bad       :boolean          default("false")
#  phone_mobile      :string(255)      default("")
#  phone_mobile_bad  :boolean          default("false")
#  phone_home        :string(255)      default("")
#  phone_home_bad    :boolean          default("false")
#  phone_alt         :string(255)      default("")
#  phone_alt_bad     :boolean          default("false")
#  do_not_mail       :boolean          default("false")
#  do_not_call       :boolean          default("false")
#  do_not_email      :boolean          default("false")
#  keep_informed     :boolean          default("false")
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

FactoryGirl.define do
  factory :supporter do
    first_name          "Test"
    last_name           "User"
    address1            "1 Market Street"
    address2            "Suite 100"
    address_city        "San Francisco"
    address_state       "CA"
    address_zip         "12345"
    email_1             { ("a".."z").to_a.shuffle[0,10].join + "sup@example.com" }
    phone_mobile          '5553234322'
    phone_home            '5553232325'
    phone_alt             '5554954933'
    vol_level             2
    employer              "Dewey Cheetum and Howe"
    occupation            "Consultant"
    source               "Door"
    notes                 "Some notes"
    supporter_type
  end
end
