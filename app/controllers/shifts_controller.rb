class ShiftsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @employee = Employee.find(params[:employee_id])
    if @employee
      @shift = @employee.shifts.build
      gon.shift_types = ShiftType.multipliers # send the ShiftType data to the client for the raised calculator
      authorize @shift
    else
      flash[:error] = 'Could not find employee.'
      render root_path  # TODO: Fix. Render probably not correct
    end
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @shift = @employee.shifts.build(shift_params)
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
    @donations = @shift.donations.limit(20)
    @employee = @shift.employee
    authorize @shift
  end

  def index
    # Pundit policy scopes don't seem to work since user is delegated/user_id isn't in the Shifts table.
    if current_user.role? :manager
      @shifts = Shift.all
    elsif current_user.role? :staff
      @shifts = current_user.shifts
    end
    authorize @shifts
  end

  def edit
    @shift = Shift.find(params[:id])
    @employee = @shift.employee
    authorize @shift
  end

  def update
    @shift = Shift.find(params[:id])
    @employee = @shift.employee
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
      params.require(:shift).permit(:shift_type_id, :field_manager_employee_id, :time_in, :time_out, :break_time, :notes,
                                    :date, :travel_reimb, :reported_raised)
    end
end