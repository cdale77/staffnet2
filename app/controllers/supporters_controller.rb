class SupportersController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @supporter = Supporter.new
    @supporter_types = SupporterType.all
    #authorize @supporter
  end

  def create

    #authorize @supporter
  end
end