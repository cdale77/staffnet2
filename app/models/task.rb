# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  shift_id   :integer
#  project_id :integer
#  name       :string(255)      default("")
#  hours      :decimal(8, 2)    default(0.0)
#  desc       :string(255)      default("")
#  notes      :text             default("")
#  created_at :datetime
#  updated_at :datetime
#

class Task < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :shift
  belongs_to :project

  
end
