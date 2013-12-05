# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  shift_id     :integer
#  project_id   :integer
#  task_type_id :integer
#  name         :string(255)      default("")
#  hours        :decimal(8, 2)    default(0.0)
#  desc         :string(255)      default("")
#  notes        :text             default("")
#  created_at   :datetime
#  updated_at   :datetime
#

class Task < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :shift
  belongs_to :project
  belongs_to :task_type
  delegate :user, to: :shift

  ## VALIDATIONS

  validates :name, presence: { message: 'required.' }

  validates :hours, presence: { message: 'required.' },
            numericality: { message: 'must be a number.' }

  validate :hours_validator


  private

    def hours_validator
      errors.add(:hours, 'Tasks cannot exceed 24 hours.') unless hours > 0 && hours < 24
    end


end
