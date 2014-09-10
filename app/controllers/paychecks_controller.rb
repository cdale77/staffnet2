class PaychecksController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    @employee = Employee.find(params[:employee_id])
    @paycheck = Paycheck.find(params[:id])
    authorize @paycheck
  end
end