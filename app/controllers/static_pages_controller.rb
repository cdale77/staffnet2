class StaticPagesController < ApplicationController

  before_filter :authenticate_user!

  def home
    @employee = current_user.employee
  end
end
