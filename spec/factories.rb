FactoryGirl.define do
  factory :user do
    first_name            'Brad'
    last_name             'Johnson'
    email                 'example@example.com'
    password              'foobar7878'
    password_confirmation 'foobar7878'
  end
end
