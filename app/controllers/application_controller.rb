class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless ( current_user == @user || current_user.role?(:admin) )
    end

    def super_admin
      redirect_to root_path unless current_user.role? :super_admin
    end

    def admin
      redirect_to root_path unless current_user.role? :admin
    end

end
