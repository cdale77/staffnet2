# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  external_id       :integer
#  cim_id            :integer
#  supporter_type_id :integer
#  prefix            :string(255)      default("")
#  salutation        :string(255)      default("")
#  first_name        :string(255)      default("")
#  last_name         :string(255)      default("")
#  suffix            :string(255)      default("")
#  address_line_1    :string(255)      default("")
#  address_line_2    :string(255)      default("")
#  address_city      :string(255)      default("")
#  address_state     :string(255)      default("")
#  address_zip       :string(255)      default("")
#  address_bad       :boolean          default(FALSE)
#  email_1           :string(255)      default("")
#  email_1_bad       :boolean          default(FALSE)
#  email_2           :string(255)      default("")
#  email_2_bad       :boolean          default(FALSE)
#  phone_mobile      :string(255)      default("")
#  phone_mobile_bad  :boolean          default(FALSE)
#  phone_home        :string(255)      default("")
#  phone_home_bad    :boolean          default(FALSE)
#  phone_alt         :string(255)      default("")
#  phone_alt_bad     :boolean          default(FALSE)
#  do_not_mail       :boolean          default(FALSE)
#  do_not_call       :boolean          default(FALSE)
#  do_not_email      :boolean          default(FALSE)
#  keep_informed     :boolean          default(FALSE)
#  vol_level         :integer          default(0)
#  employer          :string(255)      default("")
#  occupation        :string(255)      default("")
#  source            :string(255)      default("")
#  notes             :string(255)      default("")
#  created_at        :datetime
#  updated_at        :datetime
#

class Supporter < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods
  include Cleaning

  ## RELATIONSHIPS
  belongs_to :supporter_type

  ## VALIDATIONS

  validates :first_name, :prefix, :salutation,
            length: { maximum: 25, minimum: 2, message: 'must be between 2 and 25 characters.' },
            allow_blank: true

  validates :last_name, presence: { message: 'required.' },
            length: { maximum: 25, minimum: 2, message: 'must be between 2 and 25 characters.' }

  validates :email_1, :email_2,
            format: { with: VALID_EMAIL_REGEX },
            allow_blank: true

  validates :phone_mobile, :phone_home, :phone_alt,
            format: { with: PHONE_REGEX, message: 'must be 10 digits' },
            allow_blank: true

  validates :address_state,
            format: { with: STATE_REGEX, message: 'must be 2 characters' },
            allow_blank: true

  validates :address_zip, presence: { message: 'required.' },
            length: { is: 5 },
            numericality: { message: 'must be 5 digits.' }

  ## CALLBACKS
  before_validation :downcase_emails
  before_validation :format_phone_numbers
  before_validation { self.salutation = first_name if self.salutation.blank? }


  private
    def downcase_emails
      self.email_1 = email_1.downcase if attribute_present?('email_1')
      self.email_2 = email_2.downcase if attribute_present?('email_2')
    end

  # make the phone number 10 digits
    def format_phone_numbers
      self.phone_mobile = clean_phone(phone_mobile) if attribute_present?('phone_mobile')
      self.phone_work = clean_phone(phone_work) if attribute_present?('phone_work')
      self.phone_alt = clean_phone(phone_alt) if attribute_present?('phone_alt')
    end
end
