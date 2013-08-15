class Users::RegistrationsController < Devise::RegistrationsController
  #def resource_params
  #  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  #end
  #private :resource_params

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  #def account_update_params
  #  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  #end
  private :sign_up_params
  #private :account_update_params
end