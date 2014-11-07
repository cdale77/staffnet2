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

  has_attached_file :downloadable_file,
              s3_headers:   { "Content-Type" => "application/octet-stream" },
              path: ":rails_root/public/system/:class/:attachment/:filename",
              s3_permissions: :private

  do_not_validate_attachment_file_type :downloadable_file
  #validates_attachment :downloadable_file,
  #       content_type: { content_type: "application/octet-stream" }
end
