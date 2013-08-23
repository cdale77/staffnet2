# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)      default("")
#  last_name              :string(255)      default("")
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
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)      default("")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #:token_authenticatable,  :registerable, :confirmable,
  #:trackable, and :omniauthable
  devise :database_authenticatable, :lockable, :timeoutable,
         :recoverable, :rememberable, :validatable


  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods


  ## VALIDATIONS
  validates :first_name, presence: { message: 'required.' },
            length: { maximum: 25, minimum: 2, message: 'must be between 2 and 25 characters.' }

  validates :last_name, presence: { message: 'required.' },
            length: { maximum: 35, minimum: 2, message: 'must be between 2 and 35 characters.' }

  validates :email, presence: { message: 'required' },
            format: { with: VALID_EMAIL_REGEX, message: 'invalid email.' },
            uniqueness: { case_sensitive: false }

  validates :password, presence: { message: 'required' },
            length: { minimum: 10, message: 'must be be at least 10 characters.' },
            on: :create

  validates :password,
            length: { minimum: 10, message: 'must be be at least 10 characters.' },
            on: :update,
            allow_blank: true


  ## CALLBACKS
  before_save { self.email = email.downcase }


  def role?(base_role)
    role.present? && User.roles.index(base_role.to_s) <= User.roles.index(role)
  end

  private
    def self.roles
      Staffnet2::Application.config.user_roles
    end

end
