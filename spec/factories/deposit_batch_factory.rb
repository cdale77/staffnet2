FactoryGirl.define do
  factory :deposit_batch do
    date Date.today
    batch_type 'installment'
  end
end