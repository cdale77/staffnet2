# == Schema Information
#
# Table name: supporters
#
#  id                :integer          not null, primary key
#  supporter_type_id :integer
#  sendy_list_id     :integer
#  legacy_id         :string(255)      default("")
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
#  address_county    :string(255)      default("")
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
#  employer          :string(255)      default("")
#  occupation        :string(255)      default("")
#  source            :string(255)      default("")
#  notes             :text             default("")
#  sendy_status      :string(255)      default("")
#  sendy_updated_at  :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  cim_customer_id   :string(255)      default("")
#  vol_level         :string(255)      default("")
#  spouse_name       :string(255)      default("")
#  prospect_group    :string(255)      default("")
#

class Supporter < ActiveRecord::Base

  has_paper_trail

  default_scope { order(created_at: :desc) }

  ## SET UP ENVIRONMENT
  include Regex
  include PeopleMethods
  include DisplayMethods
  include Cleaning

  ## RELATIONSHIPS
  belongs_to :supporter_type
  belongs_to :sendy_list
  has_many :donations, dependent: :destroy
  has_many :payments, through: :donations
  has_many :payment_profiles
  has_many :taggings
  has_many :tags, through: :taggings


  ## CALLBACKS
  # data cleaning
  before_validation { self.salutation = first_name if self.salutation.blank? }



  ## VALIDATIONS
  validates :first_name, :prefix, :salutation,
            length: { maximum: 25, message: "must be under 25 characters" },
            allow_blank: true

  validates :last_name, presence: { message: "required." },
            length: { maximum: 25, message: "must be under 25 characters" }

  validates :email_1, :email_2,
            format: { with: VALID_EMAIL_REGEX },
            allow_blank: true

  validates :phone_mobile, :phone_home, :phone_alt,
            format: { with: PHONE_REGEX, message: "must be 10 digits" },
            allow_blank: true

  validates :address_state,
            format: { with: STATE_REGEX, message: "must be 2 characters" },
            allow_blank: true

  validates :address_zip,
            length: { is: 5 },
            numericality: { message: "must be 5 digits" },
            allow_blank: true


  ## WRITERS  
  def email_1=(email)
    write_attribute(:email_1, email.downcase) if email
  end

  def email_2=(email)
    write_attribute(:email_2, email.downcase) if email
  end

  def phone_mobile=(phone)
    write_attribute(:phone_mobile, clean_phone(phone)) if phone
  end

  def phone_home=(phone)
    write_attribute(:phone_home, clean_phone(phone)) if phone
  end

  def phone_alt=(phone)
    write_attribute(:phone_alt, clean_phone(phone)) if phone
  end

  ## TAGS
  def self.tagged_with(name)
    Tag.find_by_name!(name).supporters
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
        joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  ## CLASS METHODS
  def self.current_sustainers
    all.select { |supporter| supporter.is_sustainer? }
  end


  ## INSTANCE METHODS
  def is_sustainer?
    flag = false
    self.donations.each do |donation|
      flag = true if donation.is_sustainer?
    end
    return flag
  end


  ## CIM
  def generate_cim_customer_id
    self.cim_customer_id = ( self.id + 20000 ).to_s
  end
end
