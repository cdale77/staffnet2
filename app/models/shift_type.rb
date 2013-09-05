# == Schema Information
#
# Table name: shift_types
#
#  id         :integer          not null, primary key
#  shift_type :string(255)      default("")
#  created_at :datetime
#  updated_at :datetime
#

class ShiftType < ActiveRecord::Base

  ## VALIDATIONS
  validates :shift_type, presence: { message: 'required.' },
            length: { maximum: 56, minimum: 2, message: 'must be between 2 and 56 characters.' }

  ## RELATIONSHIPS
  has_many :shifts

  def number_of_shifts
    self.shifts.count
  end

  def human_shift_type
    self.shift_type.humanize
  end

end
