class DataReportPresenter < PresenterBase
#include ActionView::Helpers::UrlHelper
#include Rails.application.routes.url_helpers

  def human_type_name 
    data_report_type_name.humanize  
  end

  def file_download_link
    link_to("Download", 
      Rails.application.routes.url_helpers.data_report_downloadable_file_path(self))
  end
end
