class ShiftTypesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @shift_type = ShiftType.new
    authorize @shift_type
  end

  def create
    @shift_type = ShiftType.new(shift_type_params)
    authorize @shift_type
    if @shift_type.save
      flash[:success] = 'Success.'
      redirect_to shift_types_path
    else
      render 'new'
    end
  end

  def index
    @shift_types = ShiftType.all
    authorize @shift_types
  end

  def edit
    @shift_type = ShiftType.find(params[:id])
    authorize @shift_type
  end

  def update
    @shift_type = ShiftType.find(params[:id])
    authorize @shift_type
    if @shift_type.update_attributes(shift_type_params)
      flash[:success] = 'Success.'
      redirect_to shift_types_path
    else
      flash[:alert] = 'Problem updating shift type.'
      render 'edit'
    end
  end


  private

    def shift_type_params
      params.require(:shift_type).permit(:name,
                                         :fundraising_shift,
                                         :quota_shift)
    end

end