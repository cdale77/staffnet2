class SendyListsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @sendy_list = SendyList.new
  end
end