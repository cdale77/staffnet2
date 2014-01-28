# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  donation_id        :integer
#  payment_profile_id :integer
#  cim_transaction_id :string(255)      default("")
#  user_id            :integer
#  deposited_at       :date
#  payment_type       :string(255)      default("")
#  captured           :boolean          default(FALSE)
#  amount             :decimal(8, 2)    default(0.0)
#  cc_last_4          :string(4)        default("")
#  cc_month           :string(2)        default("")
#  cc_year            :string(4)        default("")
#  cc_type            :string(255)      default("")
#  check_number       :string(255)      default("")
#  notes              :text             default("")
#  created_at         :datetime
#  updated_at         :datetime
#

class Payment < ActiveRecord::Base

  attr_accessor :cc_number

  ## RELATIONSHIPS
  belongs_to :donation
  has_one :payment_profile

  ## VALIDATIONS
  validates :payment_type, presence: { message: 'required.' }

  validates :amount, presence: { message: 'required.' }

  ## CALLBACKS
  before_save :store_cc_info

  def store_cc_info
    if self.cc_number
      self.cc_last_4 = cc_number[12..16]
      self.cc_type = Payment.cc_type_by_first_number(cc_number[0])
    end
  end

  

  def self.cc_type_by_first_number(number)
    case number
      when '3'
        'amex'
      when '4'
        'visa'
      when '5'
        'mc'
      when '6'
        'disc'
    end 
  end
end
