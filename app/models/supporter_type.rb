# == Schema Information
#
# Table name: supporter_types
#
#  id   :integer          not null, primary key
#  name :string(255)      default("")
#

class SupporterType < ActiveRecord::Base

  ## VALIDATIONS
  validates :name, presence: { message: 'required.' },
            length: { maximum: 56, minimum: 2, message: 'must be between 2 and 56 characters.' }

  ## RELATIONSHIPS
  has_many :supporters

  def number_of_supporters
    self.supporters.count
  end

end
