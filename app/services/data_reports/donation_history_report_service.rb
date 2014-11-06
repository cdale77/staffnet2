class DonationHistoryReportService < ServiceBase

  def initialize
    super
    @workbook_template = ExportTemplate::Excel::Workbook.new
  end

  def perform
    return @workbook_template.export_file
  end

end
