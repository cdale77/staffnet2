class PaymentProfilesController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  ## AJAX

  def new
    @payment_profile = PaymentProfile.new
    #authorize @payment_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @new_payment_profile = PaymentProfile.new(payment_profile_params)
    #authorize @new_payment_profile
    if @new_payment_profile.save
      @result = true
    else
      @result = false
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def payment_profile_params
      params.require(:payment_profile).permit(:supporter_id, :payment_profile_type, :cc_number)
    end
end