# == Schema Information
#
# Table name: donations
#
#  id             :integer          not null, primary key
#  legacy_id      :integer
#  supporter_id   :integer
#  shift_id       :integer
#  date           :date
#  donation_type  :string(255)      default("")
#  source         :string(255)      default("")
#  campaign       :string(255)      default("")
#  sub_month      :string(1)        default("")
#  sub_week       :integer          default(0)
#  amount         :decimal(8, 2)    default(0.0)
#  cancelled      :boolean          default(FALSE)
#  notes          :text             default("")
#  created_at     :datetime
#  updated_at     :datetime
#  evolve_ed_fund :boolean          default(FALSE)
#

class Donation < ActiveRecord::Base

  has_paper_trail

  default_scope { order(date: :desc) }

  # this comes from the donation new form, the result of the select box for
  # monthly or quarterly sustainers
  attr_accessor :sustainer_type

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :supporter
  belongs_to :shift, touch: true
  has_many :payments, dependent: :destroy

  ## CALLBACKS
  before_save     :set_sustainer_codes
  after_save      :set_sustainer
  after_update    :remove_sustainer

  ## VALIDATIONS
  validates :source, :date, presence: { message: "required" }

  validates :sub_month,
            length: { is: 1 },
            format: { with: ALPHA_ONLY_REGEX, 
                      message: "must be a single alpha character" },
            allow_blank: true

  validates :sub_week,
            length: { is: 1},
            numericality: { message: "must be a single alpha character" },
            allow_blank: true


  ## Class methods
  def self.sustaining_donations
    where("sub_month <> '' AND cancelled = false")
  end

  def self.captured_donations
    all.select { |d| d.captured }
  end

  def self.uncaptured_donations
    all.select { |d| !d.captured }
  end

  def self.current_quarter_code
    month = Date.today.strftime("%B")

    a = ["January", "April", "July", "October" ]
    b = ["February", "May", "August", "November" ]
    c = ["March", "June", "September", "December" ]

    if a.include?(month)
      "a"
    elsif b.include?(month)
      "b"
    elsif c.include?(month)
      "c"
    end
  end

  def self.current_week_code
    Date.today.week_of_month
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
      when nil
        "one-time"
      when ""
        "one-time"
      when "m"
        "monthly"
      when "a"
        "quarterly"
      when "b"
        "quarterly"
      when "c"
        "quarterly"
      else
        "error"
    end
  end

  def captured
    # this is mapped to the first payment - if it's captured, so is the donation
    # if for some reason there is no first payment, the return false
    most_recent_payment ? most_recent_payment.captured : false
  end

=begin
  def payments_current?
    if most_recent_payment && \
       most_recent_payment.captured && \
       sub_month == self.class.current_quarter_code && \
       (most_recent_payment.deposited_at - Date.today).to_i < 27
      return true
    else
      return false
    end
  end
=end


  def total_value
    if self.frequency == "one-time"
      return self.amount

    elsif self.shift

      if self.frequency == "monthly"
        return ( self.amount * self.shift.shift_type.monthly_cc_multiplier )
      elsif self.frequency == "quarterly"
        return ( self.amount * self.shift.shift_type.quarterly_cc_multiplier )
      end

    else
      return ( self.amount * DEFAULT_DONATION_MULTIPLIERS[self.frequency] )
    end
  end

  def most_recent_payment
    payments.first if payments.any?
  end

  private

    def set_sustainer
      if self.is_sustainer?
        self.supporter.update_attributes(sustainer: true)
      end
    end

    def remove_sustainer
      if self.sub_month.present? && self.sub_week.present? && self.cancelled == true
        self.supporter.update_attributes(sustainer: false)
      end
    end

    def set_sustainer_codes
      if self.sub_month.blank?
        set_sub_month
        set_sub_week
      end
    end

    def set_sub_month
      if self.sustainer_type == "monthly"
        self.sub_month = "m"
      elsif self.sustainer_type == "quarterly"
        self.sub_month = Donation.current_quarter_code
      end
    end

    def set_sub_week
      if self.sustainer_type == 'monthly' || self.sustainer_type == 'quarterly'
        self.sub_week = Date.today.week_of_month.to_s
      end
    end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |donation|
          csv << donation.attributes.values_at(*column_names) + donation.supporter.full_name.split(",")
        end
      end
    end


end
