class InstallmentsController < ApplicationController

  # using before_filters for authorization here because it is awkward in Pundit.
  before_filter :admin, only: [:review]

  def review
    @deposit_batches = DepositBatch.installment_batches_to_be_approved
  end
end