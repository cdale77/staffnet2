class CalculatePaycheckService < ServiceBase
  
  def initialize(paycheck)
    @paycheck = paycheck
    @total_shifts = paycheck.shifts
    @cv_shifts = @total_shifts.select { |s| s.fundraising_shift }
    @quota_shifts = @total_shifts.select { |s| s.quota_shift }
    @office_shifts = @total_shifts.select { |s| s.shift_type_name == "office" }
    @sick_shifts = @total_shifts.select { |s| s.shift_type_name == "sick" }
    @vacation_shifts = @total_shifts.select { |s| s.shift_type_name == "vacation" }
    @holiday_shifts = @total_shifts.select { |s| s.shift_type_name == "holiday" }
    @total_deposit = @total_shifts.map(&:total_deposit).inject(0, &:+)
    @gross_credit = @total_shifts.map(&:gross_fundraising_credit).inject(0, &:+)
    @net_credit = 0
    @total_pay = @total_shifts.count * @paycheck.employee.pay_daily
    @travel_reimb = @total_shifts.map(&:travel_reimb).inject(0, &:+)
  end
  
  def perform

    values = {
        shift_quantity:           @total_shifts.count,
        cv_shift_quantity:        @cv_shifts.count,
        quota_shift_quantity:     @quota_shifts.count,
        office_shift_quantity:    @office_shifts.count,
        sick_shift_quantity:      @sick_shifts.count,
        vacation_shift_quantity:  @vacation_shifts.count,
        holiday_shift_quantity:   @holiday_shifts.count,
        total_deposit:            @total_deposit,
        gross_fundraising_credit: @gross_credit,
        net_fundraising_credit:   @net_credit,
        total_pay:                @total_pay,
        travel_reimb:             @travel_reimb
    }

    @paycheck.update_attributes(values)
  end
end