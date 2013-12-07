class ShiftTypesController < ApplicationController

  before_filter :admin

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

  def edit
    @shift_type = ShiftType.find(params[:id])
  end

  def update
    @shift_type = ShiftType.find(params[:id])
    if @shift_type.update_attributes(shift_type_params)
      flash[:success] = 'Success.'
      redirect_to shift_types_path
    else
      flash[:error] = 'Problem updating shift type.'
      render 'edit'
    end
  end

  def destroy
    @shift_type = ShiftType.find(params[:id])
    if @shift_type.number_of_shifts > 0
      flash[:error] = 'Cannot delete this task type.'
    else
      @shift_type.destroy
      flash[:success] = 'Shift type destroyed.'
    end
    redirect_to shift_types_path
  end


  private

    def shift_type_params
      params.require(:shift_type).permit(:name)
    end

end