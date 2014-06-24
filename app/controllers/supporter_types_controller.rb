class SupporterTypesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @supporter_type = SupporterType.new
    authorize @supporter_type
  end

  def create
    @supporter_type = SupporterType.new(supporter_type_params)
    authorize @supporter_type
    if @supporter_type.save
      flash[:success] = 'Success.'
      redirect_to supporter_types_path
    else
      render 'new'
    end
  end

  def index
    @supporter_types = SupporterType.all
    authorize @supporter_types
  end

  def edit
    @supporter_type = SupporterType.find(params[:id])
    authorize @supporter_type
  end

  def update
    @supporter_type = SupporterType.find(params[:id])
    authorize @supporter_type
    if @supporter_type.update_attributes(supporter_type_params)
      flash[:success] = 'Success.'
      redirect_to supporter_types_path
    else
      flash[:alert] = 'Problem updating supporter type.'
      render 'edit'
    end
  end

  private

    def supporter_type_params
      params.require(:supporter_type).permit(:name)
    end

end