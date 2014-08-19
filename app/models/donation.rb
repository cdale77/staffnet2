# == Schema Information
#
# Table name: donations
#
#  id            :integer          not null, primary key
#  legacy_id     :integer
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

  has_paper_trail

  # this comes from the donation new form, the result of the select box for
  # monthly or quarterly sustainers
  attr_accessor :sustainer_type

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :supporter
  belongs_to :shift
  has_many :payments, dependent: :destroy

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


  ## Class methods
  def self.sustaining_donations
    where("sub_month <> '' AND cancelled = false")
  end


  def is_sustainer?
    if sub_month.present? && sub_week.present? && cancelled == false
      true
    else
      false
    end
  end

  def frequency
    case self.sub_month
      when ""
        "one-time"
      when "m"
        "monthly"
      else
        "quarterly"
    end
  end

  def captured
    # this is mapped to the first payment - if it's captured, so is the donation
    self.payments.first.captured
  end

  def total_value
    case self.frequency
      when "one-time"
        return self.amount
      when "monthly"
        return ( self.amount * self.shift.shift_type.monthly_cc_multiplier )
      when "quarterly"
        return ( self.amount * self.shift.shift_type.quarterly_cc_multiplier )
      else
        return self.amount
    end
  end

  private

    def set_sustainer_codes
      if self.sub_month.blank?
        set_sub_month
        set_sub_week
      end
    end

    def set_sub_month
      if self.sustainer_type == 'monthly'
        self.sub_month = 'm'
      elsif self.sustainer_type == 'quarterly'
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
