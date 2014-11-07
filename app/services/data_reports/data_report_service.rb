class DataReportService < ServiceBase

  def initialize(data_report:)
    super
    @data_report = data_report
  end

  def perform
    report_type = @data_report.data_report_type_name

    export_file = case report_type
    when "donation_history"
      DonationHistoryReportService.new.perform
    when "database"
      DatabaseReportService.new.perform
    else
      ""
    end

    file_name = "#{report_type}-#{I18n.l(Date.today)}.xlsx"
    @data_report.update_attributes!({ downloadable_file: export_file,
                                      downloadable_file_file_name: file_name })
  end
end
