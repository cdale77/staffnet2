# == Schema Information
#
# Table name: donations
#
#  id            :integer          not null, primary key
#  supporter_id  :integer
#  shift_id      :integer
#  date          :date
#  donation_type :string(255)      default("")
#  source        :string(255)      default("")
#  campaign      :string(255)      default("")
#  sub_month     :string(1)        default("")
#  sub_week      :integer          default(0)
#  amount        :decimal(8, 2)    default(0.0)
#  cancelled     :boolean          default(FALSE)
#  notes         :text             default("")
#  created_at    :datetime
#  updated_at    :datetime
#

class Donation < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :supporter
  belongs_to :shift
  has_many :payments

 ## VALIDATIONS
  validates :source, presence: { message: 'required.' }

  validates :sub_month,
            length: { is: 1 },
            format: { with: ALPHA_ONLY_REGEX, message: 'must be a single aplhpa character.' },
            allow_blank: true

  validates :sub_week,
            length: { is: 1},
            numericality: { message: 'must be a single aplhpa character.' },
            allow_blank: true
end
