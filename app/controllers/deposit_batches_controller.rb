class DepositBatchesController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    deposit_batch = DepositBatch.find(params[:id])
    @deposit_batch_presenter = DepositBatchPresenter.new(deposit_batch)
    @payment_presenters = PaymentPresenter.wrap(deposit_batch.payments)
    authorize deposit_batch
  end

  def index
    # Batch up any new payments
    DepositBatch.batch_up
    deposit_batches = DepositBatch.all.limit(20)
    @deposit_batch_presenters = DepositBatchPresenter.wrap(deposit_batches)
    authorize deposit_batches
  end

  def edit
    @deposit_batch = DepositBatch.find(params[:id])
    authorize @deposit_batch
  end

  def update
    @deposit_batch = DepositBatch.find(params[:id])
    authorize @deposit_batch
    new_attributes = deposit_batch_params
    new_attributes[:employee_id] = current_user.employee.id
    if @deposit_batch.update_attributes(new_attributes)
      flash[:success] = "Batch approved"
      redirect_to deposit_batches_path
    end


  end


  private
    def deposit_batch_params
      params.require(:deposit_batch).permit(:receipt_number, :approved)
    end
end