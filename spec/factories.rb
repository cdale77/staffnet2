FactoryGirl.define do
  factory :user do
    first_name            'Brad'
    last_name             'Johnson'
    sequence(:email)       {|n| "user#{n}@example.com" }
    password              'foobar7878'
    password_confirmation 'foobar7878'
  end
end
