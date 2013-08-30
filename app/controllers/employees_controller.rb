class EmployeesController < ApplicationController

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:success] = 'Success.'
      redirect_to employee_path(@employee)
    else
      render 'new'
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end


  private

    def employee_params
      params.require(:employee).permit( :first_name, :last_name, :email, :phone, :address1, :address2, :city, :state,
                                        :zip, :title, :pay_hourly, :pay_daily, :hire_date, :term_date, :fed_filing_status,
                                        :ca_filing_status, :fed_allowances, :ca_allowances, :dob, :gender, :active)
    end

end