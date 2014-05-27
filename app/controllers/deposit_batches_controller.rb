class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @deposit_batch = DepositBatch.new
    @payments = Payment.to_be_deposited
    authorize @deposit_batch
  end
end