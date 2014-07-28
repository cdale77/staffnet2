class UsersController < ApplicationController

  # using before_filters for authorization here because it is awkward in Pundit.
  # Tests for this code are in
  # the user features spec.
  before_filter :super_admin, only: [:new, :create, :edit, :update]
  before_filter :admin, only: [:index, :destroy]
  before_filter :authorize_user, only: :show


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Success.'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
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
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:first_name, :last_name, :email, :role, :employee_id)
      else
        params.require(:user).permit(:first_name, :last_name, :email, :role, :employee_id, :password, :password_confirmation)
      end
    end

    #kind of hacky 1-time method to make sure the user is looking at their own records. Implemented differently in other
    #models
    def authorize_user
      redirect_to root_path unless ( current_user == User.find(params[:id]) || current_user.role?(:admin) )
    end
end
