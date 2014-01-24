class DonationsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter = Supporter.find(params[:supporter_id])
    if @supporter
      @donation = @supporter.donations.build
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
    if @supporter.save
      flash[:success] = 'Success.'
      redirect_to supporter_path(@supporter)
    else
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
    flash[:success] = 'Donatoipn destroyed.'
    redirect_to donations_path
  end

  private

    def donation_params
      params.require(:donation).permit( :date, :donation_type, :source, :campaign, :sub_month, :sub_week, :amount,
                                        :cancelled, :notes )
    end
end