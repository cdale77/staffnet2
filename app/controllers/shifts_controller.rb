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


  private

    def shift_params
      params.require(:shift).permit(:employee_id, :shift_type_id, :time_in, :time_out, :break_time, :notes,
                                    :date, :travel_reimb)
    end
end