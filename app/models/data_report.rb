# == Schema Information
#
# Table name: data_reports
#
#  id                             :integer          not null, primary key
#  user_id                        :integer
#  data_report_type_name          :string           default("")
#  downloadable_file_file_name    :string
#  downloadable_file_content_type :string
#  downloadable_file_file_size    :integer
#  downloadable_file_updated_at   :datetime
#  created_at                     :datetime
#  updated_at                     :datetime
#

class DataReport < ActiveRecord::Base 

  default_scope { order(created_at: :desc) }

  belongs_to :user
end
