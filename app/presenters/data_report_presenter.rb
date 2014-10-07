class DataReportPresenter < PresenterBase

  def human_type_name 
    data_report_type_name.humanize  
  end

  def file_download_link
    ""
  end
end
