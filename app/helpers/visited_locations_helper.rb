module VisitedLocationsHelper

	def visited_locations_header(user)
		if user.present? && user == current_user
			"My Visited Locations"
		elsif user.present?
			"#{user.name} Visited Locations"
		else
			"All Visited Locations"
		end
	end

end
