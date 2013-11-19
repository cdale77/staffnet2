class ClientsController < ApplicationController

  #include Pundit
  #after_filter :verify_authorized

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = 'Client created'
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def index
    @clients = Client.all
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
#    authorize @client
    if @client.update_attributes(client_params)
      flash[:success] = 'Client updated'
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def destroy
    client = Client.find(params[:id])
#    authorize client
    client.destroy
    flash[:success] = 'Client destroyed.'
    redirect_to clients_url
  end

  private
    def client_params
      params.require(:client).permit( :name, :address1, :address2, :city, :state, :zip, :contact_name, :contact_email,
                                      :contact_phone, :uri, :notes)
    end

end