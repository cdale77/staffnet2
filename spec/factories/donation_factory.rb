# == Schema Information
#
# Table name: donations
#
#  id            :integer          not null, primary key
#  legacy_id     :integer
#  supporter_id  :integer
#  shift_id      :integer
#  date          :date
#  donation_type :string           default("")
#  source        :string           default("")
#  campaign      :string           default("")
#  sub_month     :string(1)        default("")
#  sub_week      :integer          default("0")
#  amount        :decimal(8, 2)    default("0.0")
#  cancelled     :boolean          default("false")
#  notes         :text             default("")
#  created_at    :datetime
#  updated_at    :datetime
#

FactoryGirl.define do
  factory :donation do
    date              Date.today
    donation_type     'cash'
    source            'mail'
    campaign          'energy'
    amount            10.00
    supporter
  end
end
