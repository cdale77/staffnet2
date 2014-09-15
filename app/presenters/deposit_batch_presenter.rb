class DepositBatchPresenter < PresenterBase


  def not_approved
    !approved
  end

  def human_name
    batch_type.humanize
  end

  def formatted_date
    I18n.l(date)
  end

  def payment_count
    payments.count
  end

  def payment_total
    number_to_currency(payments.where(captured: true).sum(:amount))
  end


  def approved_by
    employee.full_name ||= ""
  end

   def formatted_created_at
     I18n.l(created_at, format: :long)
   end

   def formatted_updated_at
     I18n.l(updated_at, format: :long)
   end
end
