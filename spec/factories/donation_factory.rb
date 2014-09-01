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
