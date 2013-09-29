class ShiftsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @shift = Shift.new
    authorize @shift
  end

  def create
    @shift = Shift.new(shift_params)
    authorize @shift
    if @shift.save
      flash[:success] = 'Success.'
      redirect_to shift_path(@shift)
    else
      render 'new'
    end
  end

  def show
    @shift = Shift.find(params[:id])
    authorize @shift
  end

  def index
    @shifts = Shift.all
    #@shifts = policy_scope(Shift)
    authorize @shifts
  end

  def edit
    @shift = Shift.find(params[:id])
    authorize @shift
  end

  def update
    @shift = Shift.find(params[:id])
    authorize @shift
    if @shift.update_attributes(shift_params)
      flash[:success] = 'Shift updated.'
      redirect_to shift_path(@shift)
    else
      render 'edit'
    end
  end

  def destroy
    shift = Shift.find(params[:id])
    authorize shift
    shift.destroy
    flash[:success] = 'Shift destroyed.'
    redirect_to shifts_path
  end


  private

    def shift_params
      params.require(:shift).permit(:employee_id, :shift_type_id, :time_in, :time_out, :break_time, :notes,
                                    :date, :travel_reimb)
    end
end