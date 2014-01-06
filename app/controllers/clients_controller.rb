class ClientsController < ApplicationController

  include Pundit
  after_filter :verify_authorized

  def new
    @client = Client.new
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client
    if @client.save
      flash[:success] = 'Client created'
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def show
    @client = Client.find(params[:id])
    authorize @client
  end

  def index
    @clients = Client.all
    authorize @clients
  end

  def edit
    @client = Client.find(params[:id])
    authorize @client
  end

  def update
    @client = Client.find(params[:id])
    authorize @client
    if @client.update_attributes(client_params)
      flash[:success] = 'Client updated'
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def destroy
    client = Client.find(params[:id])
    authorize client
    client.destroy
    flash[:success] = 'Client destroyed.'
    redirect_to clients_url
  end

  private
    def client_params
      params.require(:client).permit( :name, :address1, :address2, :address_city, :address_state, :address_zip,
                                      :contact_name, :contact_email, :contact_phone, :uri, :notes)
    end

end