class SendyListsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @sendy_list = SendyList.new
    @supporter_types = SupporterType.all
  end

  def create
    @sendy_list = SendyList.new(sendy_list_params)
    if @sendy_list.save
      flash[:success] = 'Saved new Sendy list.'
      redirect_to sendy_lists_path
    else
      flash[:error] = 'Something went wrong.'
      render 'new'
    end
  end

  def index
    @sendy_lists = SendyList.all
  end

  def sendy_list_params
    params.require(:sendy_list).permit(:supporter_type_id, :name, :sendy_list_identifier)
  end
end