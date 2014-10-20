class PayrollPresenter < PresenterBase

  def formatted_end_date
    I18n.l(end_date)
  end
end