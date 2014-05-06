class PledgeEmailController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @message = PledgeEmail.new
    @employees = Employee.all
    authorize @message
  end

  def create
    @supporter = Supporter.find(params[:id])
    employee = Employee.find(params[:employee_id])
    @message = PledgeEmail.new(@supporter, employee, message_params)
    authorize @message
  end
end