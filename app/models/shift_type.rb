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
  validates :shift_type, presence: { message: 'required.' }

  ## RELATIONSHIPS
  has_many :shifts



end
