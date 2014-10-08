class DataReportPresenter < PresenterBase
#include ActionView::Helpers::UrlHelper
#include Rails.application.routes.url_helpers

  def human_type_name 
    data_report_type_name.humanize  
  end

  def file_download_link
    file_name = downloadable_file_file_name
    unless file_name.blank?
      link_to(file_name, 
        Rails.application.routes.url_helpers.data_report_downloadable_file_path(self))
    end
  end
end
