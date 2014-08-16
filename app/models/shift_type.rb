# == Schema Information
#
# Table name: shift_types
#
#  id                      :integer          not null, primary key
#  name                    :string(255)      default("")
#  monthly_cc_multiplier   :decimal(8, 2)    default(0.0)
#  quarterly_cc_multiplier :decimal(8, 2)    default(0.0)
#  created_at              :datetime
#  updated_at              :datetime
#

class ShiftType < ActiveRecord::Base

  has_paper_trail

  ## VALIDATIONS
  validates :name, presence: { message: 'required.' },
            length: { maximum: 56, minimum: 2, message: 'must be between 2 and 56 characters.' }

  ## RELATIONSHIPS
  has_many :shifts

  def self.multipliers
    result = {}
    all.each do |shift_type|
      multipliers = { monthly: shift_type.monthly_cc_multiplier, quarterly: shift_type.quarterly_cc_multiplier }
      result[shift_type.id] = multipliers
    end
    return result
  end

  def number_of_shifts
    self.shifts.count
  end

  def human_name
    self.name.humanize
  end

end
