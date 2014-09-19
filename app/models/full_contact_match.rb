# == Schema Information
#
# Table name: full_contact_matches
#
#  id           :integer          not null, primary key
#  supporter_id :integer
#  payload      :json
#  created_at   :datetime
#  updated_at   :datetime
#

class FullContactMatch < ActiveRecord::Base

  belongs_to :supporter
end
