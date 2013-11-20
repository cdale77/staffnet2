# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("")
#  address1      :string(255)      default("")
#  address2      :string(255)      default("")
#  city          :string(255)      default("")
#  state         :string(255)      default("")
#  zip           :string(255)      default("")
#  contact_name  :string(255)      default("")
#  contact_phone :string(255)      default("")
#  contact_email :string(255)      default("")
#  uri           :string(255)      default("")
#  notes         :text             default("")
#  created_at    :datetime
#  updated_at    :datetime
#

class Client < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  has_many :projects, dependent: :destroy

  ## Validations

  validates :name, presence: { message: 'required.' }

  validates :state,
            format: { with: STATE_REGEX, message: 'must be two upper-case letters.' },
            allow_blank: true

  validates :contact_phone,
            format: { with: PHONE_REGEX, message: 'must be 10 digits' },
            allow_blank: true

  validates :contact_email,
            format: { with: VALID_EMAIL_REGEX },
            allow_blank: true


end
