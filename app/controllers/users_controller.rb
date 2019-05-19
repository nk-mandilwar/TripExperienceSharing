class UsersController < ApplicationController
  
  def index
    @users = fetch_unfriend_users
    @outgoing = current_user.requests
  end

  private

  def fetch_unfriend_users
  	User.fetch_unfriend_users(current_user.id)
  end  

end