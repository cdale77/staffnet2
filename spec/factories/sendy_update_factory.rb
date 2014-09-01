FactoryGirl.define do
  factory :sendy_update do
    sendy_email     'example@example.com'
    new_sendy_email 'new_example@example.com'
    new_sendy_status  'subscribed'
    action          'subscribe'
    success         true
  end
end