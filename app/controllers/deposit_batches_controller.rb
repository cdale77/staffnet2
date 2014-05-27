class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @deposit_batch = DepositBatch.new
  end
end