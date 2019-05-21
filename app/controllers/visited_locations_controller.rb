class VisitedLocationsController < ApplicationController
  
  def index
  	@user = User.find_by_id params[:user_id]
  	verify_user(@user) if @user
  end

  def create
  	VisitedLocation.create({
  		user_id: current_user.id,
  		city: params[:city],
  		latitude: params[:latitude],
  		longitude: params[:longitude]
  	})
  	flash[:notice] = "Location added to your visited location. Please rate the location."
  	redirect_to root_path
  end

  def all
  	user = params[:user_id].present? ? User.find_by_id(params[:user_id]) : current_user
  	verify_user(user)
  	visited_locations = user.visited_locations.select(:latitude, :longitude)
  	friends_visited_locations = params[:user_id].present? ? [] : user.friends_visited_locations
    render json: {
      success: true, 
      visited_locations: visited_locations,
      friends_visited_locations: friends_visited_locations
    }
  end 

end