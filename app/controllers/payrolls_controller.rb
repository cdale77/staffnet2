class PayrollsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    payroll = Payroll.find(params[:id])
    @payroll_presenter = PayrollPresenter.new(payroll)
    authorize payroll
  end

  def index 
    payrolls = Payroll.all
    @payroll_presenters = PayrollPresenter.wrap(payrolls).paginate(page: params[:page])
    authorize payrolls
  end
end
