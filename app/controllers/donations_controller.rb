class DonationsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @supporter = Supporter.find(params[:supporter_id])
    if @supporter
      @donation = @supporter.donations.build
      #authorize @shift
    else
      flash[:error] = 'Could not find supporter.'
      render root_path  # TODO: Fix. Render probably not correct
    end
  end
end