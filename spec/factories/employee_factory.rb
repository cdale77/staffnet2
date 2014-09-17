# == Schema Information
#
# Table name: employees
#
#  id                                   :integer          not null, primary key
#  user_id                              :integer
#  legacy_id                            :string(255)      default("")
#  first_name                           :string(255)      default("")
#  last_name                            :string(255)      default("")
#  email                                :string(255)      default("")
#  phone                                :string(255)      default("")
#  address1                             :string(255)      default("")
#  address2                             :string(255)      default("")
#  address_city                         :string(255)      default("")
#  address_state                        :string(255)      default("")
#  address_zip                          :string(255)      default("")
#  title                                :string(255)      default("")
#  pay_hourly                           :decimal(8, 2)    default("0.0")
#  pay_daily                            :decimal(8, 2)    default("0.0")
#  hire_date                            :date
#  term_date                            :date
#  fed_filing_status                    :string(255)      default("")
#  ca_filing_status                     :string(255)      default("")
#  fed_allowances                       :integer          default("0")
#  ca_allowances                        :integer          default("0")
#  dob                                  :date
#  gender                               :string(255)      default("")
#  active                               :boolean          default("true")
#  notes                                :text             default("")
#  created_at                           :datetime
#  updated_at                           :datetime
#  daily_quota                          :decimal(8, 2)    default("0.0")
#  shifts_lifetime                      :decimal(8, 2)    default("0.0")
#  shifts_this_pay_period               :decimal(8, 2)    default("0.0")
#  shifts_this_week                     :decimal(8, 2)    default("0.0")
#  fundraising_shifts_lifetime          :decimal(8, 2)    default("0.0")
#  fundraising_shifts_this_pay_period   :decimal(8, 2)    default("0.0")
#  fundraising_shifts_this_week         :decimal(8, 2)    default("0.0")
#  donations_lifetime                   :decimal(8, 2)    default("0.0")
#  donations_this_pay_period            :decimal(8, 2)    default("0.0")
#  donations_this_week                  :decimal(8, 2)    default("0.0")
#  successful_donations_lifetime        :decimal(8, 2)    default("0.0")
#  successful_donations_this_pay_period :decimal(8, 2)    default("0.0")
#  successful_donations_this_week       :decimal(8, 2)    default("0.0")
#  raised_lifetime                      :decimal(8, 2)    default("0.0")
#  raised_this_pay_period               :decimal(8, 2)    default("0.0")
#  raised_this_week                     :decimal(8, 2)    default("0.0")
#  average_lifetime                     :decimal(8, 2)    default("0.0")
#  average_this_pay_period              :decimal(8, 2)    default("0.0")
#  average_this_week                    :decimal(8, 2)    default("0.0")
#

FactoryGirl.define do
  factory :employee do
    first_name          "Test"
    last_name           "User"
    phone               "5101234567"
    email               ("a".."z").to_a.shuffle[0,10].join + "employee@example.com"
    address1            "1 Market Street"
    address2            "Suite 100"
    address_city        "San Francisco"
    address_state       "CA"
    address_zip         "12345"
    title               "organizer"
    pay_hourly          12
    fed_filing_status   "single"
    ca_filing_status    "single"
    fed_allowances      2
    ca_allowances       2
    dob                 Date.today - 20.years
    hire_date           Date.today - 1.year
    term_date           Date.today
    gender              "f"
    active              true
    user
  end
end
