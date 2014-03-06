class SupportersController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter = Supporter.new
    @supporter_types = SupporterType.all
    authorize @supporter
  end

  def create
    supporter_type = SupporterType.find(params[:supporter][:supporter_type_id])
    @supporter = supporter_type.supporters.build(supporter_params)
    authorize @supporter
    if @supporter.save
      new_supporter_tasks
      redirect_to supporter_path(@supporter)
    else
      flash[:error] = 'Error saving new supporter.'
      render 'new'
    end
  end

  def show
    @supporter = Supporter.find(params[:id])
    @donations = @supporter.donations
    @supporter_type = @supporter.supporter_type
    authorize @supporter
  end

  def index
    @search = Supporter.search(params[:q])
    @supporters = @search.result.paginate(:page => params[:page], per_page: 50)
    @search.build_condition
    authorize @supporters
  end

  def edit
    @supporter = Supporter.find(params[:id])
    authorize @supporter
  end

  def update
    @supporter = Supporter.find(params[:id])
    authorize @supporter
    if @supporter.update_attributes(supporter_params)
      flash[:success] = 'Supporter updated.'
      redirect_to supporter_path(@supporter)
    else
      render 'edit'
    end
  end

  def destroy
    supporter = Supporter.find(params[:id])
    authorize supporter
    supporter.destroy
    flash[:success] = 'Supporter destroyed.'
    redirect_to supporters_url
  end

  private

    def new_supporter_tasks
      service = SupporterService.new(@supporter.id, @supporter.email_1)
      service.new_supporter ? flash[:success] = 'Saved new supporter.' : flash[:error] = "Error: #{service.message}"
    end

    def supporter_params
      params.require(:supporter).permit(  :prefix, :salutation, :first_name, :last_name, :suffix, :address_line_1,
                                          :address_line_2, :address_city, :address_state, :address_zip, :address_bad,
                                          :email_1, :email_1_bad, :email_2, :email_2_bad, :phone_mobile,
                                          :phone_mobile_bad, :phone_home, :phone_home_bad, :supporter_type_id )
    end
end