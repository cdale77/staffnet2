class SendyListsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @sendy_list = SendyList.new
    authorize @sendy_list
  end

  def create
    @sendy_list = SendyList.new(sendy_list_params)
    authorize @sendy_list
    if @sendy_list.save
      flash[:success] = 'Saved new Sendy list.'
      redirect_to sendy_lists_path
    else
      flash[:alert] = 'Something went wrong.'
      render 'new'
    end
  end

  def index
    @sendy_lists = SendyList.all
    authorize @sendy_lists
  end

  def edit
    @sendy_list = SendyList.find(params[:id])
    authorize @sendy_list
  end

  def update
    @sendy_list = SendyList.find(params[:id])
    authorize @sendy_list
    if @sendy_list.update_attributes(sendy_list_params)
      flash[:success] = 'Sendy list updated.'
      redirect_to sendy_lists_path
    else
      render 'edit'
    end
  end

  private
    def sendy_list_params
      params.require(:sendy_list).permit(:supporter_type_id, :name, :sendy_list_identifier)
    end
end