class PaymentsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    @payment = Payment.find(params[:id])
    @payment_profile = @payment.payment_profile if @payment
    @deposit_batch = @payment.deposit_batch if @payment
    @donation = @payment.donation if @payment
    @supporter = @donation.supporter if @donation
    authorize @payment
  end
end