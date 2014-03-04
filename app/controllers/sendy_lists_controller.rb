class SendyListsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @sendy_list = SendyList.new
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

  def edit
    @sendy_list = SendyList.find(params[:id])
  end

  def update
    @sendy_list = SendyList.find(params[:id])
    if @sendy_list.update_attributes(sendy_list_params)
      flash[:success] = 'Sendy list updated.'
      redirect_to sendy_lists_path
    else
      render 'edit'
    end
  end

  def sendy_list_params
    params.require(:sendy_list).permit(:supporter_type_id, :name, :sendy_list_identifier)
  end
end