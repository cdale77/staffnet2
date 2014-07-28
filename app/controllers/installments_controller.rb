class InstallmentsController < ApplicationController

  # using before_filters for authorization here because it is awkward in Pundit.
  before_filter :admin, only: [:review]

  def review
  end
end