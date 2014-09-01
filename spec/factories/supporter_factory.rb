FactoryGirl.define do
  factory :supporter do
    first_name          "Test"
    last_name           "User"
    address1            "1 Market Street"
    address2            "Suite 100"
    address_city        "San Francisco"
    address_state       "CA"
    address_zip         "12345"
    email_1             ("a".."z").to_a.shuffle[0,10].join + "sup@example.com"
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