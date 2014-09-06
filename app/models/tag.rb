# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base

  # no paper trail

  has_many :taggings
  has_many :supporters, through: :taggings
end
