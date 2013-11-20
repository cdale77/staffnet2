# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  name       :string(255)      default("")
#  start_date :date
#  end_date   :date
#  desc       :string(255)      default("")
#  notes      :text             default("")
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :client

  ## VALIDATIONS
  validates :name, presence: { message: 'required.' }
  
end
