FactoryGirl.define do

  factory :user do
    first_name            'Brad'
    last_name             'Johnson'
    sequence(:email)       {|n| "user#{n}@example.com" }
    role                   ''
    password              'foobar7878'
    password_confirmation 'foobar7878'

    factory :super_admin do
      role              'super_admin'
    end

    factory :admin do
      role              'admin'
    end

    factory :manager do
      role              'manager'
    end

    factory :staff do
      role              'staff'
    end
  end
end
