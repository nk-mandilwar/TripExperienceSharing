class ApplicationController < ActionController::Base
	
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
  	root_path
	end

	def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected 

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def verify_user(user)
    if !(user == current_user || (current_user.friends.include? user))
      redirect_to root_path
    end
  end

end
