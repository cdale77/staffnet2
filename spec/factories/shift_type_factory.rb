# == Schema Information
#
# Table name: shift_types
#
#  id                      :integer          not null, primary key
#  name                    :string(255)      default("")
#  monthly_cc_multiplier   :decimal(8, 2)    default("0.0")
#  quarterly_cc_multiplier :decimal(8, 2)    default("0.0")
#  created_at              :datetime
#  updated_at              :datetime
#  fundraising_shift       :boolean          default("false")
#  quota_shift             :boolean          default("true")
#  workers_comp_type       :string(255)      default("")
#

FactoryGirl.define do
  factory :shift_type do
    name                  ['street', 'door', 'office', 'phone'].sample
    monthly_cc_multiplier    7
    quarterly_cc_multiplier  3
    workers_comp_type     ["inside", "outside"].sample
  end
end
