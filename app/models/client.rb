# == Schema Information
#
# Table name: clients
#
#  id            :integer          not null, primary key
#  name          :string(255)      default("")
#  address1      :string(255)      default("")
#  address2      :string(255)      default("")
#  address_city  :string(255)      default("")
#  address_state :string(255)      default("")
#  address_zip   :string(255)      default("")
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
  include Cleaning

  ## RELATIONSHIPS
  #has_many :projects, dependent: :destroy

  ## Validations

  validates :name, presence: { message: 'required.' }

  validates :address_state,
            format: { with: STATE_REGEX, message: 'must be two upper-case letters.' },
            allow_blank: true

  validates :contact_phone,
            format: { with: PHONE_REGEX, message: 'must be 10 digits' },
            allow_blank: true

  validates :contact_email,
            format: { with: VALID_EMAIL_REGEX },
            allow_blank: true

  
  
  def contact_phone=(phone)
    write_attribute(:contact_phone, clean_phone(phone))
  end

  def contact_email=(email)
    write_attribute(:contact_email, email.downcase)
  end



end
