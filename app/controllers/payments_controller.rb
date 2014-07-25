class PaymentsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def show
    @payment = Payment.find(params[:id])
  end
end