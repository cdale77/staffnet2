FactoryGirl.define do
  factory :payment do
    payment_type          'cash'
    captured              true
    amount                10.00
    processed             true
    receipt_sent_at       Time.now
    donation
  end

end