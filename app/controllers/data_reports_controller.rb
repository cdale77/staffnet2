class DataReportsController < ApplicationController 

  include Pundit
  after_filter :verify_authorized

  def new
    @data_report = DataReport.new 
    authorize @data_report
  end

  def create 
    @data_report = DataReport.new(data_report_params)
    authorize @data_report
    if @data_report.save 
      DataReportJob.enqueue(@data_report.id)
      flash[:success] = "Report queued. Refresh to check on completion."
      redirect_to data_reports_path
    else
      flash[:danger] = "Something went wrong. Try creating the report again."
      render "new"
    end
  end

  def index
    data_reports = DataReport.all
    authorize data_reports
    @data_report_presenters = DataReportPresenter.wrap(data_reports)
  end

  def downloadable_file
    data_report = DataReport.find(params[:id])
    authorize data_report
    redirect_to data_report.downloadable_file.expiring_url(10)
  end

  private

    def data_report_params
      params.require(:data_report).permit(:data_report_type_name)
    end

end
