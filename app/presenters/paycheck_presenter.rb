class PaycheckPresenter < PresenterBase

  def formatted_check_date
    I18n.l(check_date)
  end

  def formatted_bonus
    number_to_currency(bonus)
  end

  def formatted_travel_reimb
    number_to_currency(travel_reimb)
  end

  def formatted_total_pay
    number_to_currency(total_pay)
  end

  def other_shift_quantity
    holiday_shift_quantity + vacation_shift_quantity + sick_shift_quantity
  end

  def formatted_gross_fundraising_credit
    number_to_currency(gross_fundraising_credit)
  end

  def formatted_total_deposit
    number_to_currency(total_deposit)
  end

  def formatted_total_quota
    number_to_currency(total_quota)
  end

  def formatted_total_credits
    number_to_currency(credits)
  end

  def formatted_total_docks
    number_to_currency(docks)
  end

  def formatted_net_fundraising_credit
    number_to_currency(net_fundraising_credit)
  end

  def formatted_old_buffer
    number_to_currency(old_buffer)
  end

  def formatted_new_buffer
    number_to_currency(new_buffer)
  end

  def formatted_over_quota
    number_to_currency(over_quota)
  end

  def employee_full_name
    employee.full_name
  end

  def employee_last_name
    employee.last_name
  end
end

