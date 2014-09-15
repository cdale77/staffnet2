class DepositBatchPresenter < PresenterBase

  def initialize(deposit_batch)

    @payments = deposit_batch.payments
    super
  end

  def not_approved
    !approved
  end

  def human_name
    batch_type.humanize
  end

  def date
    I18n.l(date)
  end

  def payment_count
    @payments.count
  end

  def payment_total
    number_to_currency(@payments.where(captured: true).sum(:amount))
  end

  def approved_by
    employee.full_name ||= ""
  end


end
