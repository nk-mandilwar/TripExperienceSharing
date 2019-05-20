class LocationReviewsController < ApplicationController

	before_action :set_user, only: :index

	def index
		@location_reviews = @user.location_reviews
	end

	def new
		@visited_location = VisitedLocation.find_by_id params[:visited_location_id]
		@user = @visited_location.user
		redirect_to root_path if @user != current_user
		@location_review = LocationReview.new
	end

	def create
		@user = User.find_by_id location_review_params["user_id"]
		@visited_location = VisitedLocation.find_by_id location_review_params[:visited_location_id]
		redirect_to root_path if @user != current_user || @user != @visited_location.user 
		@location_review = LocationReview.new(location_review_params)
		if @location_review.save
			rating = @user.rating
			rating ||= Rating.new(user_id: @user.id)
			rating_service = RatingService.new(location_review_params)
			rating.set_rate(rating_service.set_rating_points)
			redirect_to location_reviews_path(user_id: @user.id)
		else
			render 'new'
		end
	end

	private

	def set_user
		@user = User.find_by_id params[:user_id]
		verify_user(@user)
	end

	def location_review_params
    params.require(:location_review).permit(:user_id, :visited_location_id, :rating, :feedback)
  end

end
