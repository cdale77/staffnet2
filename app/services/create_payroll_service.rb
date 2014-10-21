class CreatePayrollService < ServiceBase

  def initialize
    super
    @payroll = Payroll.new
  end

  def perform
    @payroll.set_start_and_end_dates
    @payroll.save
    paycheck_service = CreatePaychecksService.new(payroll: @payroll)
    paycheck_service.perform
  end

  
  private
    def update_payroll_totals
      paychecks = @payroll.paychecks
      attributes = {
        check_quantity: paychecks.count,
        shift_quantity: paychecks.sum(:shift_quantity),
        cv_shift_quantity: paychecks.sum(:cv_shift_quantity),
        quota_shift_quantity: paychecks.sum(:quota_shift_quantity),
        office_shift_quantity: paychecks.sum(:office_shift_quantity),
        sick_shift_quantity: paychecks.sum(:sick_shift_quantity),
        holiday_shift_quantity: paychecks.sum(:holiday_shift_quantity),
        vacation_shift_quantity: paychecks.sum(:vacation_shift_quantity),
        total_deposit: paychecks.sum(:total_deposit),
        gross_fundraising_credit: paychecks.sum(:gross_fundraising_credit),
        net_fundraising_credit: paychecks.sum(:net_fundraising_credit)
      }
      @payroll.update_attributes(attributes)
      @payroll.save
    end
end
