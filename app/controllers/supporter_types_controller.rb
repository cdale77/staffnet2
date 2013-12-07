class SupporterTypesController < ApplicationController

  before_filter :admin

  def new
    @supporter_type = SupporterType.new
  end

  def create
    @supporter_type = SupporterType.new(supporter_type_params)
    if @supporter_type.save
      flash[:success] = 'Success.'
      redirect_to supporter_types_path
    else
      render 'new'
    end
  end

  def index
    @supporter_types = SupporterType.all
  end

  def edit
    @supporter_type = SupporterType.find(params[:id])
  end

  def update
    @supporter_type = SupporterType.find(params[:id])
    if @supporter_type.update_attributes(supporter_type_params)
      flash[:success] = 'Success.'
      redirect_to supporter_types_path
    else
      flash[:error] = 'Problem updating supportertype.'
      render 'edit'
    end
  end

  private

    def supporter_type_params
      params.require(:supporter_type).permit(:name)
    end

end