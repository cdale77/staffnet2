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

require "spec_helper"

describe DataReport do 

  report_attrs = SpecData.data_report_attributes 
  let!(:report) { DataReport.new(data_report_type_name: "all_supporters") }

  subject { report }

  ## ATTRIBUTES
  describe 'attribute tests' do 
    report_attrs.each do |k,v|
      it { should respond_to(k) }
    end
  end

  ## RELATIONSHIPS
  it { should respond_to(:user) }

end
