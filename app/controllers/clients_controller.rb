class ClientsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @client = Client.new
  end

  def create

  end

  def show

  end

  def index

  end

  def edit

  end

  def update

  end

  def destroy

  end

end