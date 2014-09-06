# == Schema Information
#
# Table name: migration_errors
#
#  id          :integer          not null, primary key
#  record_id   :integer
#  record_name :string           default("")
#  message     :string           default("")
#  created_at  :datetime
#  updated_at  :datetime
#

class MigrationError < ActiveRecord::Base

end
