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
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  role                   :string(255)      default("")
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do

  user_attributes = SpecData.user_attributes

  before do
    @user = User.new(user_attributes)
  end

  subject { @user }

  ## ATTRIBUTES
  describe 'attribute tests' do
    user_attributes.each do |key, value|
      it { should respond_to(key) }
    end

    it { should be_valid }
  end

  ## RELATIONSHIPS
  it { should respond_to(:employee) }
  it { should respond_to(:shifts) }
  it { should respond_to(:data_reports) }
  #it { should respond_to(:tasks) }

  ## VALIDATIONS
  describe 'email validations' do
    it 'should reject invalid emails' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
    it 'should accept valid emails' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
    it 'should downcase emails before saving' do
      @user.email = 'EXAMPLE@example.com'
      @user.save
      @user.email.should eq 'example@example.com'
    end
  end
  describe 'passwords' do
    it 'should reject users with no password' do
      @user.password = ''
      @user.password_confirmation = ''
      @user.should_not be_valid
    end
    it 'should reject users with mismatched passwords' do
      @user.password_confirmation = 'foobar88'
      @user.should_not be_valid
    end
    it 'should reject too short passwords' do
      @user.password = 'a' * 9
      @user.password_confirmation = 'a' * 9
      @user.should_not be_valid
    end
  end


end
