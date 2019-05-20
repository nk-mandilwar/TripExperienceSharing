module LocationReviewsHelper

  def location_reviews_header(user)
  	if user == current_user
  		"My Reviews"
  	else
  		"#{user.name} Reviews"
  	end
  end

end