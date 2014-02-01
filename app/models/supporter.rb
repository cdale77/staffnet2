# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  supporter_type_id :integer
#  external_id       :string(255)      default("")
#  cim_id            :string(255)      default("")
#  prefix            :string(255)      default("")
#  salutation        :string(255)      default("")
#  first_name        :string(255)      default("")
#  last_name         :string(255)      default("")
#  suffix            :string(255)      default("")
#  address1          :string(255)      default("")
#  address2          :string(255)      default("")
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
#  notes             :text             default("")
#  created_at        :datetime
#  updated_at        :datetime
#

class Supporter < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods
  include DisplayMethods
  include Cleaning
  #include MailChimpMethods

  ## RELATIONSHIPS
  belongs_to :supporter_type
  has_many :donations, dependent: :destroy
  has_many :payments, through: :donations


  ## CALLBACKS
  #before_create :set_mailchimp_sync_stamp
  after_create :store_cim_profile
  before_destroy :unstore_cim_profile
  before_validation { self.salutation = first_name if self.salutation.blank? }


  ## VALIDATIONS
  validates :first_name, :prefix, :salutation,
            length: { maximum: 25, message: 'must be under 25 characters.' },
            allow_blank: true

  validates :last_name, presence: { message: 'required.' },
            length: { maximum: 25, message: 'must be under 25 characters.' }

  validates :email_1, :email_2,
            format: { with: VALID_EMAIL_REGEX },
            allow_blank: true

  validates :phone_mobile, :phone_home, :phone_alt,
            format: { with: PHONE_REGEX, message: 'must be 10 digits' },
            allow_blank: true

  validates :address_state,
            format: { with: STATE_REGEX, message: 'must be 2 characters' },
            allow_blank: true

  validates :address_zip,
            length: { is: 5 },
            numericality: { message: 'must be 5 digits.' },
            allow_blank: true

  ## WRITERS  
  def email_1=(email)
    write_attribute(:email_1, email.downcase)
  end

  def email_2=(email)
    write_attribute(:email_2, email.downcase)
  end

  def phone_mobile=(phone)
    write_attribute(:phone_mobile, clean_phone(phone))
  end

  def phone_home=(phone)
    write_attribute(:phone_home, clean_phone(phone))
  end

  def phone_alt=(phone)
    write_attribute(:phone_alt, clean_phone(phone))
  end


  def store_cim_profile
    if cim_id.blank?
      profile = Cim::Profile.new(self.id, self.email_1)
      begin
        profile.store
      rescue
        puts 'ERROR: Problem creating CIM profile: ' + profile.server_message
      end
      self.cim_id = profile.cim_id if profile.cim_id
    end
  end

  def unstore_cim_profile
    profile = Cim::Profile.new(self.id, self.email_1, self.cim_id.to_s)
    begin
      self.cim_id = '' if profile.unstore
    rescue
      puts 'ERROR: Problem destroying CIM profile: ' + profile.server_message
    end
  end

=begin
  def self.mailchimp_create_records
    connection = Gibbon::API.new
    connection.timeout = 60
    response = connection.lists.batch_subscribe( id: ENV['MAILCHIMP_LIST_ID'],
                                                 batch: mailchimp_update_array,
                                                 double_optin: false)
    store_leid(response)
  end

  def self.mailchimp_update_records
    connection = Gibbon::API.new
    connection.timeout = 60
    connection.lists.batch_subscribe( id: ENV['MAILCHIMP_LIST_ID'],
                                                 batch: mailchimp_update_array,
                                                 update_existing: true,
                                                 double_optin: false)
  end


  def self.store_leid(mailchimp_repsonse)
    mailchimp_response['adds'].each do |response|
      supporter = Supporter.find_by_email(response['email'])
      supporter.mailchimp_leid = response['leid']
      supporter.save
    end
  end

  def self.mailchimp_update_array
    array = []
    mailchimp_records_to_sync.each do |record|
      array << record.mailchimp_record_hash
    end
    array
  end

  def mailchimp_record_hash
    {
        email:      self.mailchimp_email_hash,
        merge_vars: {
                      FNAME:  self.first_name,
                      LNAME:  self.last_name,
                      zip:    self.address_zip,
                      groupings:  [{
                                      id: ENV['MAILCHIMP_LIST_SUPPORTER_GROUP_ID'],
                                      groups: [self.supporter_type.name]
                                   }]
                    }
    }
  end

  def mailchimp_email_hash
    if self.mailchimp_leid.blank?
      {
          email: self.email_1
      }
    else
      {
          new_email:  self.email_1,
          leid:       self.mailchimp_leid
      }
    end
  end
=end


end
