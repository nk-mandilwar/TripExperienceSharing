class LoctionReview < ApplicationRecord
  belongs_to :user
  belongs_to :visited_location
end
