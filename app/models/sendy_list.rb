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

  has_paper_trail

  ## RELATIONSHIPS
  belongs_to :supporter_type
  has_many :supporters

  ## VALIDATIONS
  validates :name, presence: { message: "required" }
  validates :sendy_list_identifier, presence: { message: "'required" }

  ## WRITERS
  def name=(name)
    write_attribute(:name, name.downcase)
  end

end
