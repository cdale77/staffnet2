class ShiftTypesController < ApplicationController

  def new
    @shift_type = ShiftType.new
  end

  def create
    @shift_type = ShiftType.new(shift_type_params)
    if @shift_type.save
      flash[:success] = 'Success.'
      redirect_to shift_types_path
    else
      render 'new'
    end
  end

  def index
    @shift_types = ShiftType.all
  end


  private

    def shift_type_params
      params.require(:shift_type).permit(:shift_type)
    end

end