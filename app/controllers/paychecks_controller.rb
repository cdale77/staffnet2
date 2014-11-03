class PaychecksController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    paycheck = Paycheck.find(params[:id])
    @paycheck_presenter = PaycheckPresenter.new(paycheck)
    @shift_presenters = ShiftPresenter.wrap(paycheck.shifts)
    authorize paycheck
  end

  def edit
    @paycheck = Paycheck.find(params[:id])
    authorize @paycheck
  end

  def update
    @paycheck = Paycheck.find(params[:id])
    authorize @paycheck
    if @paycheck.update_attributes(paycheck_params)
      flash[:success] = "Paycheck updated."
      CalculatePaycheckService.new(paycheck: @paycheck).perform
    else
      flash[:danger] = "Something went wrong"
      render "edit"
    end
  end


  private

    def paycheck_params
      params.require(:paycheck).permit(:credits, :docks)
    end
end
