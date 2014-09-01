FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    email
    role                  ''
    confirmation_sent_at  Time.now
    confirmed_at          Time.now
    password              'foobar7878'
    password_confirmation 'foobar7878'

    factory :super_admin do
      email
      role              'super_admin'
    end

    factory :admin do
      email
      role              'admin'
    end

    factory :manager do
      email
      role              'manager'
    end

    factory :staff do
      email
      role              'staff'
    end
  end
end