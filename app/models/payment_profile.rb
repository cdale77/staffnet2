# == Schema Information
#
# Table name: payment_profiles
#
#  id                     :integer          not null, primary key
#  supporter_id           :integer
#  cim_payment_profile_id :string(255)      default("")
#  payment_profile_type   :string(255)      default("")
#  details                :hstore           default({})
#  created_at             :datetime
#  updated_at             :datetime
#

class PaymentProfile < ActiveRecord::Base

  ## HSTORE
  store_accessor(:details, :cc_last_4, :cc_type, :cc_month, :cc_year)

  ## RELATIONSHIPS
  belongs_to :supporter 
  has_many :payments

  ## CALLBACKS
  after_create :store_cim_payment_profile
  before_destroy :unstore_cim_payment_profile

  def store_cim_payment_profile

  end

  def unstore_cim_payment_profile

  end

end
