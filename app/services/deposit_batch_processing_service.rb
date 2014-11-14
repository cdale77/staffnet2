class DepositBatchProcessingService < ServiceBase

  def initialize(deposit_batch)
    @deposit_batch = deposit_batch
  end

  def perform
    if @deposit_batch.processable?
      InstallmentPaymentsJob.perform_later(@deposit_batch.id)
    end
  end
end

