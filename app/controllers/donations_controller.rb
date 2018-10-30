class DonationsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter = Supporter.find(params[:supporter_id])
    session[:current_controller] = "#donation"
    if @supporter
      @donation = @supporter.donations.build
      @payment = @donation.payments.build
      @payment_profiles = @supporter.payment_profiles.limit(2)
      @shifts = Shift.first(25)
      authorize @donation
    else
      flash[:danger] = "Could not find supporter"
      redirect_to root_path
    end
  end

  def create
    new_donation_params = donation_params
    new_donation_params.delete(:payment_profile_id)
    session[:current_controller] = "#donation"
    @supporter = Supporter.find(params[:supporter_id])
    if @supporter
      @donation = @supporter.donations.build(new_donation_params)
      authorize @donation
      if @donation.save
        @payment = @donation.payments.build
        @payment.payment_profile_id = donation_params[:payment_profile_id]
        @payment.payment_type = @donation.donation_type
        @payment.amount = @donation.amount
        @payment.process_payment
        @payment.send_receipt if @payment.captured
        if @payment.save
          flash[:success] = "Success"
          redirect_to donation_path(@donation)
        end
      else
        @shifts = Shift.all.limit(15)
        @payment_profiles = @supporter.payment_profiles.limit(5)
        render "new"
      end
    end
  end

  def show
    donation = Donation.find(params[:id])
    @donation_presenter = DonationPresenter.new(donation)
    @payment_presenters = PaymentPresenter.wrap(donation.payments)
    authorize donation
  end

  def index
    query = params[:q]
    @search = Donation.search(query)
    @search.build_condition
    @donations = query ? @search.result.includes(:supporter) : Donation.all.limit(100)
    @donation_presenters = DonationPresenter.wrap(@donations). \
                            paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @donations.to_csv }
      format.xls { send_data @donations.to_csv(col_sep: "\t") }
    end

    authorize @donations
  end

  def edit
    @donation = Donation.find(params[:id])
    @supporter = @donation.supporter
    @shifts = Shift.where('created_at > ?', 3.weeks.ago)
    authorize @donation
  end

  def update
    @donation = Donation.find(params[:id])
    @supporter = @donation.supporter
    authorize @donation
    if @donation.update_attributes(donation_params)
      flash[:success] = "Donation updated"
      redirect_to donation_path(@donation)
    else
      render "edit"
    end
  end

  def destroy
    donation = Donation.find(params[:id])
    authorize donation
    donation.destroy
    flash[:success] = "Donation destroyed"
    redirect_to donations_path
  end

  private

    def donation_params
      params.require(:donation).permit( :date,
                                        :donation_type,
                                        :source,
                                        :campaign,
                                        :sub_month,
                                        :sub_week,
                                        :amount,
                                        :cancelled,
                                        :notes,
                                        :sustainer_type,
                                        :shift_id,
                                        :payment_profile_id)
    end
end
