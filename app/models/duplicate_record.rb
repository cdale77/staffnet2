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
#

class DuplicateRecord < ActiveRecord::Base


end
