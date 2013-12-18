class SupportersController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @supporter = Supporter.new
    @supporter_types = SupporterType.all
    #authorize @supporter
  end

  def create
    supporter_type = SupporterType.find(params[:supporter][:supporter_type_id])
    @supporter = supporter_type.supporters.build(supporter_params)
    #authorize @supporter
    if @supporter.save
      flash[:success] = 'Saved new supporter.'
      redirect_to supporter_path(@supporter)
    else
      flash[:error] = 'Something went wrong.'
      render 'new'
    end
  end

  def show
    @supporter = Supporter.find(params[:id])
    @supporter_type = @supporter.supporter_type
  end


  private

    def supporter_params
      params.require(:supporter).permit(  :prefix, :salutation, :first_name, :last_name, :suffix, :address_line_1,
                                          :address_line_2, :address_city, :address_state, :address_zip, :address_bad,
                                          :email_1, :email_1_bad, :email_2, :email_2_bad, :phone_mobile,
                                          :phone_mobile_bad, :phone_home, :phone_home_bad, )
    end
end