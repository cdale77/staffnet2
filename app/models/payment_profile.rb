# == Schema Information
#
# Table name: payment_profiles
#
#  id                     :integer          not null, primary key
#  supporter_id           :integer
#  cim_payment_profile_id :string(255)      default("")
#  payment_profile_type   :string(255)      default("")
#  details                :hstore           default("")
#  created_at             :datetime
#  updated_at             :datetime
#

class PaymentProfile < ActiveRecord::Base

  has_paper_trail

  attr_accessor :cc_number

  ## SET UP ENVIRONMENT
  include Regex

  ## HSTORE
  store_accessor :details, :cc_last_4, :cc_type, :cc_month, :cc_year

  ## RELATIONSHIPS
  belongs_to :supporter 
  has_many :payments

  ## CALLBACKS
  before_save :store_cc_info
  before_destroy :unstore_cim_payment_profile

  ## VALIDATIONS
  validates :payment_profile_type, presence: { message: "required" }

  def short_version
    profile_type = self.payment_profile_type || ""
    cc_type = self.cc_type || ""
    cc_last_4 = self.cc_last_4 || ""
    cc_year = self.cc_year || ""
    
    "#{profile_type.humanize} - #{cc_type.humanize} \
      x#{cc_last_4} #{self.cc_month}/#{cc_year}"
  end

  def store_cc_info
    if self.cc_number
      self.cc_last_4 = cc_number[12..16]
      self.cc_type = PaymentProfile.cc_type_by_first_number(cc_number[0])
    end
  end

  def unstore_cim_payment_profile
    unless self.cim_payment_profile_id.blank?
      cim_payment_profile = Cim::PaymentProfile.new(self.supporter,
                                                    "", "", "", "",
                                                    self.cim_payment_profile_id)
      cim_payment_profile.unstore
    end
  end

  def self.cc_type_by_first_number(number)
    case number
      when "3"
        "amex"
      when "4"
        "visa"
      when "5"
        "mc"
      when "6"
        "disc"
    end
  end
end
