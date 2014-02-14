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

  attr_accessor :frequency

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :supporter
  belongs_to :shift
  has_many :payments, dependent: :destroy
  accepts_nested_attributes_for :payments

  ## CALLBACKS
  before_save :set_sustainer_codes

  ## VALIDATIONS
  validates :source, :date, presence: { message: 'required.' }

  validates :sub_month,
            length: { is: 1 },
            format: { with: ALPHA_ONLY_REGEX, message: 'must be a single alpha character.' },
            allow_blank: true

  validates :sub_week,
            length: { is: 1},
            numericality: { message: 'must be a single alpha character.' },
            allow_blank: true

  def is_sustainer?
    sub_month.present? ? true : false
  end

  private
    def set_sustainer_codes
      unless self.frequency.blank?
        set_sub_month
        set_sub_week
      end
    end

    def set_sub_month
      if self.frequency == 'monthly'
        'm'
      elsif self.frequency == 'quarterly'
        self.sub_month = quarter_code
      end
    end

    def set_sub_week
      self.sub_week = Date.today.week_of_month.to_s
    end

    def quarter_code
      month = Date.today.strftime("%B")

      a = ['January', 'April', 'July', 'October' ]
      b = ['February', 'May', 'August', 'November' ]
      c = ['March', 'June', 'September', 'December' ]

      if a.include?(month)
        'a'
      elsif b.include?(month)
        'b'
      elsif c.include?(month)
        'c'
      end
    end

end
