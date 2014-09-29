module DepositBatchesHelper 

  def cache_key_for_deposit_batches
    count          = DepositBatch.count
    max_updated_at = DepositBatch.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "deposit_batches/all-#{count}-#{max_updated_at}"
  end
end
