class LocationReviewsController < ApplicationController

	before_action :set_user, only: :index

	def index
		@location_reviews = location_reviews
	end

	def new
		@visited_location = VisitedLocation.find_by_id params[:visited_location_id]
		@user = @visited_location.user
		redirect_to root_path if @user != current_user
		@location_review = LocationReview.new
	end

	def create
		@user = User.find_by_id location_review_params["user_id"]
		redirect_to root_path if @user != current_user
		LocationReview.create(location_review_params)
		@rating = @user.rating
		@rating ||= Rating.new(user_id: @user.id)
		@rating.set_rate(location_review_params)
		redirect_to location_reviews_path(user_id: @user.id)
	end

	private

	def set_user
		@user = User.find_by_id params[:user_id]
		verify_user(@user)
	end

	def location_reviews
		@user.visited_locations.joins("left outer join location_reviews lr on lr.visited_location_id = visited_locations.id").
		select("visited_locations.id as id, visited_locations.city as city, lr.id as lr_id, lr.rating as rating, lr.feedback as feedback")
	end

	def location_review_params
      params.require(:location_review).permit(:user_id, :visited_location_id, :rating, :feedback)
    end

end
