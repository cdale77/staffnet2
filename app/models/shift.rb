# == Schema Information
#
# Table name: shifts
#
#  id           :integer          not null, primary key
#  employee_id  :integer
#  date         :date
#  shift_type   :string(255)      default("")
#  time_in      :time
#  time_out     :time
#  break_time   :integer          default(0)
#  notes        :string(255)      default("")
#  travel_reimb :decimal(8, 2)    default(0.0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Shift < ActiveRecord::Base

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  belongs_to :employee

  ## VALIDATIONS


  ## CALLBACKS

end
