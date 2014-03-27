# == Schema Information
#
# Table name: migration_errors
#
#  id          :integer          not null, primary key
#  record_id   :integer
#  record_name :string(255)      default("")
#  message     :string(255)      default("")
#  created_at  :datetime
#  updated_at  :datetime
#

class MigrationError < ActiveRecord::Base

end
