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
#  notes         :text             default("")
#  travel_reimb  :decimal(8, 2)    default(0.0)
#  created_at    :datetime
#  updated_at    :datetime
#

class Shift < ActiveRecord::Base

  default_scope { order(date: :desc) }

  ## SET UP ENVIRONMENT
  include Regex

  ## RELATIONSHIPS
  #belongs_to :user
  belongs_to :employee
  delegate :user, to: :employee
  belongs_to :shift_type
  has_many :donations
  has_many :payments, through: :donations
  #has_many :tasks, dependent: :destroy

  ## VALIDATIONS
  validates :date,
            presence: { message: 'required.' }

  validates :break_time,
            numericality: { less_than_or_equal_to: 120 },
            allow_blank: true

  validates :travel_reimb,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
            allow_blank: true

  validate :shift_time_validator

  def short_version
    "#{self.date.strftime('%Y/%m/%d')}-#{self.employee.full_name}"
  end

  def net_time
    self.break_time ||= 0
    self.time_in ||= 0
    self.time_out ||= 0
    ((self.time_out - self.time_in)/3600) - ((self.break_time.to_f)/60.to_f)
  end


  private

    def shift_time_validator
      errors.add(:time_out, 'You cannot have zero or negative hours.') unless (2..24).include?(net_time)
    end

end
