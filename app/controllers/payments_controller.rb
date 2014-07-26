class PaymentsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @donation = Donation.find(params[:donation_id])
    if @donation
      @supporter = @donation.supporter
      @payment = @donation.payments.build
      @payment_profiles = @supporter.payment_profiles.limit(5)
    end
    authorize @payment
  end

  def show
    @payment = Payment.find(params[:id])
    @payment_profile = @payment.payment_profile if @payment
    @deposit_batch = @payment.deposit_batch if @payment
    @donation = @payment.donation if @payment
    @supporter = @donation.supporter if @donation
    authorize @payment
  end
end