# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0")
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default("0")
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  role                   :string(255)      default("")
#  created_at             :datetime
#  updated_at             :datetime
#

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
