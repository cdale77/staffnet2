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

=begin
class Project < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :client
  has_many :tasks, dependent: :destroy

  ## VALIDATIONS
  validates :name, presence: { message: 'required.' }
  
end
=end
