class CleanDataJob < ActiveJob::Base

  queue_as :default

  def perform

    # Remove old data reports
    DataReport.find_each(batch_size: 25) do |data_report|
      if (data_report.created_at - Time.now).to_i > 7776000 # 90 days in seconds
        data_report.destroy
      end
    end
  end
end

