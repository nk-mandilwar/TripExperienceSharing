class VisitedLocationsController < ApplicationController
  
  def index
  	@user = User.find_by_id params[:user_id]
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
  	visited_locations = user.visited_locations.select(:latitude, :longitude)
  	friends_visited_locations = params[:user_id].present? ? [] : friends_visited_locations(user)
    render json: {
      success: true, 
      visited_locations: visited_locations,
      friends_visited_locations: friends_visited_locations
    }
  end 

  private 

  def friends_visited_locations(user)
  	user.friends.joins("inner join visited_locations as vl on vl.user_id = users.id").
  	 select("vl.longitude as longitude, vl.latitude as latitude")
  end

end