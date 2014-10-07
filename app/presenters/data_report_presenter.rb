class DataReportPresenter < PresenterBase

  def human_type_name 
    data_report_type_name.humanize  
  end

  def formatted_date 
    I18n.l(updated_at)
  end

  def file_download_link
    ""
  end
end
