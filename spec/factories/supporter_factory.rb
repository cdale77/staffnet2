# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  supporter_type_id :integer
#  sendy_list_id     :integer
#  legacy_id         :string           default("")
#  external_id       :string           default("")
#  cim_id            :string           default("")
#  prefix            :string           default("")
#  salutation        :string           default("")
#  first_name        :string           default("")
#  last_name         :string           default("")
#  suffix            :string           default("")
#  address1          :string           default("")
#  address2          :string           default("")
#  address_city      :string           default("")
#  address_state     :string           default("")
#  address_zip       :string           default("")
#  address_county    :string           default("")
#  address_bad       :boolean          default("false")
#  email_1           :string           default("")
#  email_1_bad       :boolean          default("false")
#  email_2           :string           default("")
#  email_2_bad       :boolean          default("false")
#  phone_mobile      :string           default("")
#  phone_mobile_bad  :boolean          default("false")
#  phone_home        :string           default("")
#  phone_home_bad    :boolean          default("false")
#  phone_alt         :string           default("")
#  phone_alt_bad     :boolean          default("false")
#  do_not_mail       :boolean          default("false")
#  do_not_call       :boolean          default("false")
#  do_not_email      :boolean          default("false")
#  keep_informed     :boolean          default("false")
#  employer          :string           default("")
#  occupation        :string           default("")
#  source            :string           default("")
#  notes             :text             default("")
#  sendy_status      :string           default("")
#  sendy_updated_at  :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  cim_customer_id   :string           default("")
#  vol_level         :string           default("")
#  spouse_name       :string           default("")
#  prospect_group    :string           default("")
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
