# == Schema Information
#
# Table name: task_types
#
#  id   :integer          not null, primary key
#  name :string(255)      default("")
#  desc :string(255)      default("")
#

class TaskType < ActiveRecord::Base

  ## RELATIONSHIPS
  has_many :tasks

  ## VALIDATIONS

  validates :name, presence: { message: 'required.' }

end
