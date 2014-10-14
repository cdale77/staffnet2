class SupportersController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter = Supporter.new
    @supporter_types = SupporterType.all
    authorize @supporter
  end

  def create
    @supporter_type = SupporterType.find(params[:supporter][:supporter_type_id])
    @supporter = @supporter_type.supporters.build(supporter_params)
    authorize @supporter
    if @supporter.save
      new_supporter_tasks(@supporter)
      redirect_to supporter_path(@supporter)
    else
      render "new"
    end
  end

  def show
    supporter = Supporter.find(params[:id])
    @supporter_presenter = SupporterPresenter.new(supporter)
    @donation_presenters = DonationPresenter.wrap(supporter.donations.limit(20))
    authorize supporter
  end

  def index
    @search = Supporter.search(params[:q])
    @search.build_condition
    supporters = params[:q] ? @search.result : Supporter.all.limit(100)
    @supporter_presenters = SupporterPresenter.wrap(supporters).paginate(page: params[:page])
    authorize supporters
  end

  def edit
    @supporter = Supporter.find(params[:id])
    authorize @supporter
  end

  def update
    @supporter = Supporter.find(params[:id])
    authorize @supporter
    if @supporter.update_attributes(supporter_params)
      flash[:success] = "Supporter updated"
      redirect_to supporter_path(@supporter)
    else
      render "edit"
    end
  end

  def destroy
    supporter = Supporter.find(params[:id])
    authorize supporter
    destroy_supporter_tasks(supporter)
    supporter.destroy
    redirect_to supporters_url
  end

  private

    def new_supporter_tasks(supporter)
      # generate an id for the cim customer id field. add 20,000 to the
      # supporter id the service object will save the new supporter
      supporter.generate_cim_customer_id
      sendy_list = supporter.supporter_type.sendy_lists.first
      service = SupporterService.new(supporter:supporter, 
                                     sendy_list_id: sendy_list.id )
      service.new_supporter ? flash[:success] = 'Saved new supporter.' : flash[:alert] = "Error: #{service.message}"
    end

    def destroy_supporter_tasks(supporter)
      sendy_list = supporter.supporter_type.sendy_lists.first
      service = SupporterService.new(supporter: supporter, 
                                     sendy_list_id: sendy_list.id, 
                                     cim_id: supporter.cim_id )
      service.destroy_supporter ? flash[:success] = "Supporter record destroyed" : flash[:alert] = "Error: #{service.message}"
    end

    def supporter_params
      params.require(:supporter).permit(  :prefix,
                                          :salutation,
                                          :first_name,
                                          :last_name,
                                          :suffix,
                                          :address1,
                                          :address2,
                                          :address_city,
                                          :address_state,
                                          :address_zip,
                                          :address_bad,
                                          :email_1,
                                          :email_1_bad,
                                          :email_2,
                                          :email_2_bad,
                                          :phone_mobile,
                                          :phone_mobile_bad,
                                          :phone_home,
                                          :phone_home_bad,
                                          :phone_alt,
                                          :phone_alt_bad,
                                          :supporter_type_id,
                                          :do_not_call,
                                          :do_not_email,
                                          :do_not_mail,
                                          :keep_informed,
                                          :vol_level,
                                          :employer,
                                          :occupation,
                                          :tag_list,
                                          :address_county,
                                          :source,
                                          :notes,
                                          :spouse_name,
                                          :issue_knowledge)
    end
end
