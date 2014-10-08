require "active_job"

class DataReportJob < ActiveJob::Base
  queue_as :default 

  def perform(data_report_id)
    data_report = DataReport.find(data_report_id.to_i)
    if data_report
      service = DataReportService.new(data_report)
      service.perform
    end
  end
end
