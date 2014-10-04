# == Schema Information
#
# Table name: data_reports
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  data_report_type_name :string           default("")
#  string                :string           default("")
#  created_at            :datetime
#  updated_at            :datetime
#

require "spec_helper"

describe DataReport do 
