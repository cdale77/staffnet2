# == Schema Information
#
# Table name: donations
#
#  id             :integer          not null, primary key
#  legacy_id      :integer
#  supporter_id   :integer
#  shift_id       :integer
#  date           :date
#  donation_type  :string(255)      default("")
#  source         :string(255)      default("")
#  campaign       :string(255)      default("")
#  sub_month      :string(1)        default("")
#  sub_week       :integer          default(0)
#  amount         :decimal(8, 2)    default(0.0)
#  cancelled      :boolean          default(FALSE)
#  notes          :text             default("")
#  created_at     :datetime
#  updated_at     :datetime
#  evolve_ed_fund :boolean          default(FALSE)
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
