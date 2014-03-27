# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  tag_id       :integer
#  supporter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :article
end
