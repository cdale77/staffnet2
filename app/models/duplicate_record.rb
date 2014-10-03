# == Schema Information
#
# Table name: duplicate_records
#
#  id                    :integer          not null, primary key
#  first_record_id       :integer
#  additional_record_ids :string           default("{}"), is an Array
#  created_at            :datetime
#  updated_at            :datetime
#  resolved              :boolean          default("false")
#  record_type_name      :string           default("1")
#

class DuplicateRecord < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }

  def self.unresolved 
    where resolved: false
  end
end
