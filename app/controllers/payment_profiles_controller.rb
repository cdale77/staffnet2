class PaymentProfilesController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  ## AJAX


  def new
    @supporter = Supporter.find(params[:supporter_id])
    @payment_profile = @supporter.payment_profiles.build
    #authorize @payment_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @supporter = Supporter.find(params[:supporter_id])
    @payment_profile = PaymentProfile.new(payment_profile_params)
    #authorize @new_payment_profile
    if @payment_profile.save
      @success = true
    else
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end


  private
    def payment_profile_params
      params.require(:payment_profile).permit(:supporter_id, :payment_profile_type, :cc_number, :cc_month, :cc_year)
    end
end