class DataReportService < ServiceBase 

  def initialize(data_report:)
    @data_report = data_report
  end

  def perform
    report_type = @data_report.data_report_type_name

    csv_file = case report_type
    when "all_supporters"
      Exports::DonationHistory.all
    else
      ""
    end

    file_name = "#{report_type}-#{I18n.l(Date.today)}.csv"

    @data_report.update_attributes!({ downloadable_file: csv_file,
                                      downloadable_file_file_name: file_name })
  end
end
