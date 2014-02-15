class DonationsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter = Supporter.find(params[:supporter_id])
    if @supporter
      @donation = @supporter.donations.build
      @payment = @donation.payments.build
      @payment_profiles = @supporter.payment_profiles.limit(5)
      @shifts = Shift.all.limit(15)
      authorize @donation
    else
      flash[:error] = 'Could not find supporter.'
      render root_path  # TODO: Fix. Render probably not correct
    end
  end

  def create
    @supporter = Supporter.find(params[:supporter_id])
    @donation = @supporter.donations.build(donation_params)
    authorize @donation
    if @donation.save
      flash[:success] = 'Success.'
      redirect_to donation_path(@donation)
    else
      @shifts = Shift.all.limit(15)
      @payment_profiles = @supporter.payment_profiles.limit(5)
      render 'new'
    end
  end

  def show
    @donation = Donation.find(params[:id])
    @supporter = @donation.supporter
    @payments = @donation.payments
    authorize @donation
  end

  def index
    @donations = Donation.all.paginate(:page => params[:page], per_page: 50)
    authorize @donations
  end

  def edit
    @donation = Donation.find(params[:id])
    @supporter = @donation.supporter
    authorize @donation
  end

  def update
    @donation = Donation.find(params[:id])
    @supporter = @donation.supporter
    authorize @donation
    if @donation.update_attributes(donation_params)
      flash[:success] = 'donation updated.'
      redirect_to donation_path(@donation)
    else
      render 'edit'
    end
  end

  def destroy
    donation = Donation.find(params[:id])
    authorize donation
    donation.destroy
    flash[:success] = 'Donation destroyed.'
    redirect_to donations_path
  end

  private

    def donation_params
      params.require(:donation).permit( :date, :donation_type, :source, :campaign, :sub_month, :sub_week, :amount,
                                        :cancelled, :notes, :frequency, :shift_id,
                                        payments_attributes: [:payment_profile_id, :payment_type, :amount, :notes] )
    end
end