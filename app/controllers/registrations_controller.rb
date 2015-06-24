class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, 
        :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :current_password,
        :email, :password, :password_confirmation)
    end
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end
  


end
