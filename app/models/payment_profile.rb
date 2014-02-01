# == Schema Information
#
# Table name: payment_profiles
#
#  id                     :integer          not null, primary key
#  supporter_id           :integer
#  cim_payment_profile_id :string(255)      default("")
#  details                :string(255)      default("--- {}\n")
#  hstore                 :string(255)      default("--- {}\n")
#  created_at             :datetime
#  updated_at             :datetime
#

class PaymentProfile < ActiveRecord::Base

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
