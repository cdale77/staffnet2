class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def review

    authorize @deposit_batches
  end
end