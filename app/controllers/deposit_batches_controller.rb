class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def review
    @deposit_batches = DepositBatch.to_be_approved
    authorize @deposit_batches
  end
end