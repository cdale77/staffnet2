class PayrollsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def create
    authorize Payroll.new
    PayrollProcessingJob.perform_later
    flash[:success] = "Payroll job queued for processing. Refresh to check."
    redirect_to payrolls_path
  end

  def show
    payroll = Payroll.find(params[:id])
    authorize payroll
    paychecks = payroll.paychecks.limit(20)
    @payroll_presenter = PayrollPresenter.new(payroll)
    @paycheck_presenters = PaycheckPresenter.wrap(paychecks)
  end

  def index
    payrolls = Payroll.all
    @payroll_presenters = PayrollPresenter.wrap(payrolls).paginate(page: params[:page])
    authorize payrolls
  end
end

