class DataReportsController < ApplicationController 

  include Pundit
  after_filter :verify_authorized

  def new
    @data_report = DataReport.new 
    authorize @data_report
  end

end
