class PaymentsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @donation = Donation.find(params[:donation_id])
    session[:current_controller] = "#payment"
    if @donation
      @supporter = @donation.supporter
      @payment = @donation.payments.build
      @payment_profiles = @supporter.payment_profiles.limit(2)
    end
    authorize @payment
  end

  def show
    payment = Payment.find(params[:id])
    @payment_presenter = PaymentPresenter.new(payment)
    authorize payment
  end

  def create
    @donation = Donation.find(params[:donation_id])
    session[:current_controller] = "#payment"
    if @donation
      @payment = @donation.payments.build(payment_params)
      @payment.amount = @donation.amount
      @payment.payment_type = @donation.donation_type
      authorize @payment
      @payment.process_payment
      @payment.send_receipt if @payment.captured
      if @payment.save
        flash[:success] = "Success"
        redirect_to donation_path(@donation)
      end
    else
      @supporter = @donation.supporter
      @payment_profiles = @supporter.payment_profiles.limit(2)
      render "new"
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    donation = payment.donation
    authorize payment
    if payment.processed
      flash[:danger] = "Cannot delete a processed payment"
    else
      payment.destroy
      flash[:success] = "Payment destroyed"
    end
    redirect_to donation_path(donation)
  end

  private
    def payment_params
      params.require(:payment).permit(:payment_profile_id,
                                      :payment_type,
                                      :notes)
    end
end
