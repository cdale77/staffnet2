class UsersController < ApplicationController

  #before_filter :configure_permitted_parameters

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Success.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'User updated'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
=begin

  #this is for strong_parameters and Devise.
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name,
               :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :email )
    end
  end
=end
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:first_name, :last_name, :email)
      else
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
=begin
    def clean_password
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
=end
end
