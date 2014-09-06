# == Schema Information
#
# Table name: sendy_updates
#
#  id               :integer          not null, primary key
#  supporter_id     :integer
#  sendy_list_id    :integer
#  sendy_batch_id   :integer
#  sendy_email      :string           default("")
#  new_sendy_email  :string           default("")
#  new_sendy_status :string           default("")
#  action           :string           default("")
#  success          :boolean          default("false")
#  completed_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class SendyUpdate < ActiveRecord::Base

  #no paper trail
  
end
