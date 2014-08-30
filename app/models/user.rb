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

class User < ActiveRecord::Base

  has_paper_trail
  
  # Include default devise modules. Others available are:
  #:token_authenticatable,  :registerable, :confirmable,
  #:trackable, and :omniauthable
  devise :database_authenticatable, :lockable, :timeoutable,
         :recoverable, :rememberable, :validatable


  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods

  ## RELATIONSHIPS
  has_one :employee
  has_many :shifts, through: :employee
  #has_many :tasks, through: :shift


  ## VALIDATIONS

  validates :email, presence: { message: "required" },
            format: { with: VALID_EMAIL_REGEX, message: "invalid email" },
            uniqueness: { case_sensitive: false }

  validates :password, presence: { message: "required" },
            length: { minimum: 10,
                      message: "must be be at least 10 characters" },
            on: :create

  validates :password,
            length: { minimum: 10,
                      message: "must be be at least 10 characters" },
            on: :update,
            allow_blank: true


  def email=(email)
    write_attribute(:email, email.downcase)
  end


  def role?(base_role)
    role.present? && User.roles.index(base_role.to_s) <= User.roles.index(role)
  end

  private
    def self.roles
      USER_ROLES
    end

end
