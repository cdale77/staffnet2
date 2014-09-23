class PaychecksController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    paycheck = Paycheck.find(params[:id])
    @paycheck_presenter = PaycheckPresenter.new(paycheck)
    @shift_presenters = ShiftPresenter.wrap(paycheck.shifts)
    authorize paycheck
  end
end
