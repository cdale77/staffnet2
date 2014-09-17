class FinancePresenter < PresenterBase
  # Donations and payments have these two methods.
  def formatted_amount
    number_to_currency(amount)
  end

  def formatted_date
    I18n.l(date)
  end
end