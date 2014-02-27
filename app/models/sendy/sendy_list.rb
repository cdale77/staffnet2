# == Schema Information
#
# Table name: sendy_lists
#
#  id                    :integer          not null, primary key
#  supporter_type_id     :integer
#  sendy_list_identifier :string(255)      default("")
#  name                  :string(255)      default("")
#  created_at            :datetime
#  updated_at            :datetime
#

class SendyList < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :supporter_type
  has_many :supporters
end
