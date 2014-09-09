class CreatePaychecksService < ServiceBase

  def initialize(payroll)
    @payroll = payroll
    @check_date = @payroll.end_date + 6.days
    @payroll_shifts = Shift.where(date: self.start_date..self.end_date)
    @shift_groups = @payroll_shifts.group_by { |shift| shift.employee_id }
  end

  def perform
    # loop through the grouped shifts and create a check for each employee
    @shift_groups.each do |shift_group|
      employee_id = shift_group.first
      paycheck = Paycheck.create(payroll_id: @payroll.id,
                                 employee_id: employee_id,
                                 check_date: @check_date)
      shifts = shift_group.second
      shifts.each do |shift|
        shift.paycheck_id = paycheck.id
        shift.save
      end

      #when everything is set up, calculate the paycheck values and save
      paycheck.calculate_values
      paycheck.save
    end
  end
end