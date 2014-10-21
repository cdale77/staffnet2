class PayrollPresenter < PresenterBase

  def formatted_start_date
    I18n.l(start_date)
  end

  def formatted_end_date
    I18n.l(end_date)
  end

  def formatted_raised
    number_to_currency(gross_fundraising_credit)
  end

  def formatted_net_raised
    number_to_currency(net_fundraising_credit)
  end

  def formatted_total_deposit
    number_to_currency(total_deposit)
  end
end
