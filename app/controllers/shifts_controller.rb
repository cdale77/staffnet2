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
      flash[:success] = "Success"
      redirect_to shift_path(@shift)
    else
      render "new"
    end
  end

  def show
    shift = Shift.find(params[:id])
    @shift_presenter = ShiftPresenter.new(shift)
    @donation_presenters = DonationPresenter.wrap(shift.donations.limit(20))
    authorize shift
  end

  def index
    # Pundit policy scopes don't seem to work since user is delegated/user_id
    # isn't in the Shifts table.

    employee_id = params[:employee_id]
    query = params[:q]

    @search = Shift.search(query)
    @search.build_condition

    if employee_id && \
       (current_user.employee.id == employee_id || current_user.role?(:admin))

      if query
        shifts = @search.result
      else
        shifts = Employee.find(params[:employee_id]).shifts
      end

    elsif current_user.role?(:admin)
      shifts = query ? @search.result : Shift.all.limit(100)
    else
      shifts = []
    end

    @shift_presenters = ShiftPresenter.wrap(shifts).paginate(page: params[:page])
    authorize shifts
  end

  def edit
    @shift = Shift.find(params[:id])
    authorize @shift
  end

  def update
    @shift = Shift.find(params[:id])
    @employee = @shift.employee
    authorize @shift
    if @shift.update_attributes(shift_params)
      flash[:success] = "Shift updated"
      redirect_to shift_path(@shift)
    else
      render "edit"
    end
  end

  def destroy
    shift = Shift.find(params[:id])
    authorize shift
    shift.destroy
    flash[:success] = "Shift destroyed"
    redirect_to shifts_path
  end


  private

    def shift_params
      params.require(:shift).permit(:shift_type_id,
                                    :employee_id,
                                    :field_manager_employee_id,
                                    :time_in,
                                    :time_out,
                                    :break_time,
                                    :notes,
                                    :date,
                                    :travel_reimb,
                                    :reported_raised,
                                    :reported_total_yes,
                                    :reported_cash_qty,
                                    :reported_cash_amt,
                                    :reported_check_qty,
                                    :reported_check_amt,
                                    :reported_one_time_cc_qty,
                                    :reported_one_time_cc_amt,
                                    :reported_monthly_cc_qty,
                                    :reported_monthly_cc_amt,
                                    :reported_quarterly_cc_qty,
                                    :reported_quarterly_cc_amt,
                                    :phones,
                                    :emails,
                                    :signatures,
                                    :contacts,
                                    :site)
    end
end