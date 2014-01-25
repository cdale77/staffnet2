# == Schema Information
#
# Table name: payment_profiles
#
#  id           :integer          not null, primary key
#  supporter_id :integer
#  cim_id       :string(255)      default("")
#  created_at   :datetime
#  updated_at   :datetime
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
