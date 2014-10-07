module DataReportsHelper 

  def cache_key_for_data_reports
    count          = DataReport.count
    max_updated_at = DataReport.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "data-reports/all-#{count}-#{max_updated_at}"
  end

end