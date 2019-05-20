class LocationReview < ApplicationRecord
  belongs_to :user
  belongs_to :visited_location

  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5}
end
