class SendyList < ActiveRecord::Base

  ## RELATIONSHIPS
  belongs_to :supporter_type
  has_many :supporters
end