class CreatePayrollService < ServiceBase

  def initialize
    super
    @payroll = Payroll.new
  end

  def perform
    @payroll.set_start_and_end_dates
    @payroll.save
    CreatePaychecksService.new(payroll: @payroll).perform
    CalculatePayrollService.new(payroll: @payroll).perform
  end
end

