class PaychecksController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    paycheck = Paycheck.find(params[:id])
    @paycheck_presenter = PaycheckPresenter.new(paycheck)
    authorize paycheck
  end
end
