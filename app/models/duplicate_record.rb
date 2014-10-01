# == Schema Information
#
# Table name: duplicate_records
#
#  id                   :integer          not null, primary key
#  record_type          :string           default("")
#  primary_record_id    :integer
#  duplicate_record_ids :string           default("{}"), is an Array
#  created_at           :datetime
#  updated_at           :datetime
#  resolved             :boolean          default("false")
#

class DuplicateRecord < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }

  def self.unresolved 
    where resolved: false
  end
end
