class EmployeePresenter < PeoplePresenter

  def email_link
    mail_to(email, nil, class: "hover-underline-grey")
  end

  def formatted_phone
    number_to_phone(phone.to_i)
  end

  def fed_status_to_human
    fed_filing_status.humanize
  end

  def ca_status_to_human
    ca_filing_status.humanize
  end

  def title_to_human
    title.humanize
  end

  def formatted_hourly_pay
    number_to_currency(pay_hourly)
  end

  def formatted_daily_pay
    number_to_currency(pay_daily)
  end

  def formatted_dob
    I18n.l(dob)
  end

  def formatted_hire_date
    I18n.l(hire_date)
  end

  def formatted_term_date
    term_date ? I18n.l(term_date) : "Not applicable"
  end

  def formatted_raised_lifetime
    number_to_currency(raised_lifetime)
  end

  def formatted_average_lifetime
    number_to_currency(average_lifetime)
  end

  def formatted_raised_this_week
    number_to_currency(raised_this_week)
  end

  def formatted_average_this_week
    number_to_currency(average_this_week)
  end

  def formatted_status
    active ? "Active" : "Inactive"
  end
end