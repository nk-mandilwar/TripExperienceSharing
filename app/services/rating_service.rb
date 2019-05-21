class RatingService

	attr_reader :rating, :feedback

	def initialize(params, user)
		@rating = params[:rating]
		@feedback = params[:feedback]
		@user = user
	end

	def update_rating_points
  	points = 0
  	points += 1 if @rating.present?
  	points += 1 if @feedback.present?
  	rating = @user.rating
		rating ||= Rating.new(user_id: @user.id)
  	rating.points += points
  	rating.save
  end

end