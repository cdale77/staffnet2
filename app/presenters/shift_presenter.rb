class ShiftPresenter < PresenterBase

  def employee_name
    employee.full_name
  end

  def field_manager_name
    field_manager ? field_manager.full_name : ""
  end

  def shift_type_name
    shift_type ? shift_type.name.humanize : ""
  end

  def site_to_human
    site.humanize
  end

  def formatted_travel_reimb
    number_to_currency(travel_reimb)
  end

  def formatted_time_in
    I18n.l(time_in, format: :short)
  end

  def formatted_time_out
    I18n.l(time_out, format: :short)
  end

  def formatted_reported_raised
    number_to_currency(reported_raised)
  end

  def formatted_gross_fundraising_credit
    number_to_currency(gross_fundraising_credit)
  end

  def formatted_total_deposit
    number_to_currency(total_deposit)
  end
end