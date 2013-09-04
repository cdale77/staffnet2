# == Schema Information
#
# Table name: shifts
#
#  id            :integer          not null, primary key
#  employee_id   :integer
#  shift_type_id :integer
#  date          :date
#  time_in       :time
#  time_out      :time
#  break_time    :integer          default(0)
#  notes         :string(255)      default("")
#  travel_reimb  :decimal(8, 2)    default(0.0)
#  created_at    :datetime
#  updated_at    :datetime
#

class Shift < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :employee
  belongs_to :shift_type

  ## VALIDATIONS
  validates :break_time,
            numericality: { greater_than: 4, less_than: 121 },
            allow_blank: true

  validates :travel_reimb,
            numericality: { greater_than_or_equal_to: 0 },
            allow_blank: true

  ## CALLBACKS

end
