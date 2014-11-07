require "active_job"

class DataReportJob < ActiveJob::Base
  queue_as :default 

  def perform(data_report_id)
    data_report = DataReport.find(data_report_id.to_i)
    DataReportService.new(data_report: data_report).perform if data_report
  end
end

