class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    @deposit_batch = DepositBatch.find(params[:id])
    @payments = @deposit_batch.payments
    authorize @deposit_batch
  end

  def index
    DepositBatch.batch_up
    @deposit_batches = DepositBatch.to_be_approved
    authorize @deposit_batches
  end

  def edit
    @deposit_batch = DepositBatch.find(params[:id])
    authorize @deposit_batch
  end

  def update

  end
end