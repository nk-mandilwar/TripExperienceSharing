class RatingService

	attr_reader :rating, :feedback

	def initialize(params)
		@rating = params[:rating]
		@feedback = params[:feedback]
	end

	def set_rating_points
  	points = 0
  	points += 1 if @rating.present?
  	points += 1 if @feedback.present?
  	points
  end

end