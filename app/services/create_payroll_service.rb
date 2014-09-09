class CreatePayrollService < ServiceBase

  def initialize
    @success = false
    @message = ""
    @payroll = Payroll.new
  end

  def perform
    @payroll.set_start_and_end_dates
    paycheck_service = CreatePaychecksService.new(@payroll)
    if @payroll.save && paycheck_service.perform
      @success = true
    end
  end
end
