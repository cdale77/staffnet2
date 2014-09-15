class DepositBatchPresenter


  def initialize(deposit_batch)
    @deposit_batch = deposit_batch
  end

  def approved
    @deposit_batch.approved
  end

  def not_approved
    !@deposit_batch.approved
  end

  def human_name
    @deposit_batch.batch_type.humanize
  end

  def date
    I18n.l(@deposit_batch.date)
  end

end
