class EmployeesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @employee = Employee.new
    authorize @employee
  end

  def create
    @employee = Employee.new(employee_params)
    authorize @employee
    if @employee.save
      flash[:success] = "Success"
      redirect_to employee_path(@employee)
    else
      flash[:error] = "Error"
      render 'new'
    end
  end

  def show
    @employee = Employee.find(params[:id])
    @employee_presenter = EmployeePresenter.new(@employee)
    @shift_presenters = ShiftPresenter.wrap(@employee.shifts.limit(20))
    @paycheck_presenters = PaycheckPresenter.wrap(@employee.paychecks.limit(20))
    authorize @employee
  end

  def index
    employees = Employee.active
    @employee_presenters = EmployeePresenter.wrap(employees)
    authorize employees
  end

  def edit
    @employee = Employee.find(params[:id])
    authorize @employee
  end

  def update
    @employee = Employee.find(params[:id])
    authorize @employee
    if @employee.update_attributes(employee_params)
      flash[:success] = "Employee updated"
      redirect_to employee_path(@employee)
    else
      render 'edit'
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    authorize employee
    employee.destroy
    flash[:success] = "Employee destroyed"
    redirect_to employees_url
  end

  private

    def employee_params
      params.require(:employee).permit( :first_name,
                                        :last_name,
                                        :email,
                                        :phone,
                                        :address1,
                                        :address2,
                                        :address_city,
                                        :address_state,
                                        :address_zip,
                                        :title,
                                        :pay_hourly,
                                        :pay_daily,
                                        :hire_date,
                                        :term_date,
                                        :fed_filing_status,
                                        :ca_filing_status,
                                        :fed_allowances,
                                        :ca_allowances,
                                        :dob,
                                        :gender,
                                        :active,
                                        :daily_quota)
    end

    def check_owner
      unless (current_user == Employee.find(params[:id]).user || current_user.role?(:manager))
        redirect_to root_path
      end
    end

end