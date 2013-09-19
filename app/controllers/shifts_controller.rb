class ShiftsController < ApplicationController


  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      flash[:success] = 'Success.'
      redirect_to shift_path(@shift)
    else
      render 'new'
    end
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def index
    @shifts = Shift.all
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def update
    @shift = Shift.find(params[:id])
    if @shift.update_attributes(shift_params)
      flash[:success] = 'Shift updated'
      redirect_to shift_path(@shift)
    else
      render 'edit'
    end
  end


  private

    def shift_params
      params.require(:shift).permit(:employee_id, :shift_type_id, :time_in, :time_out, :break_time, :notes,
                                    :date, :travel_reimb)
    end
end