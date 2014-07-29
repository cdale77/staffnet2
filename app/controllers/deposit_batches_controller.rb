class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    @deposit_batch = DepositBatch.find(params[:id])
    authorize @deposit_batch
  end

  def index
    @deposit_batches = DepositBatch.to_be_approved
    authorize @deposit_batches
  end
end