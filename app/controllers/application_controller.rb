class ApplicationController < ActionController::Base
	
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  # to set the path after user signs in
	def after_sign_in_path_for(resource)
  	root_path
	end

  # to set the path after user logs out
	def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
