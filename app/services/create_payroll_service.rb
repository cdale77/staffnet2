class CreatePayrollService < ServiceBase

  def initialize
    @payroll = Payroll.new
  end

  def perform
    @payroll.set_start_and_end_dates
    @payroll.save
    paycheck_service = CreatePaychecksService.new(@payroll)
    paycheck_service.perform
  end
end
