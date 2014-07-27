class PaymentProfilesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  ## AJAX


  def new
    @supporter = Supporter.find(params[:supporter_id])
    @payment_profile = @supporter.payment_profiles.build
    authorize @payment_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    @supporter = Supporter.find(params[:supporter_id])
    @payment_profile = @supporter.payment_profiles.build(payment_profile_params)
    authorize @payment_profile
    @cim_profile = Cim::PaymentProfile.new(@supporter,
                                           params[:payment_profile][:cc_number],
                                           params[:payment_profile][:cc_month],
                                           params[:payment_profile][:cc_year] )
    if @cim_profile.store
      @payment_profile.cim_payment_profile_id = @cim_profile.cim_payment_profile_id
      @payment_profile.save
    end
    respond_to do |format|
      format.js
    end

  end


  private
    def payment_profile_params
      params.require(:payment_profile).permit(:supporter_id,
                                              :payment_profile_type,
                                              :cc_number,
                                              :cc_month,
                                              :cc_year)
    end
end