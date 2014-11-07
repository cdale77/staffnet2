class DatabaseReportService < ServiceBase

  def perform
    Rails.application.eager_load! unless Rails.env.production?
    models = ActiveRecord::Base.descendants
  end


end
