class VisitedLocation < ApplicationRecord
  belongs_to :user
  has_one :location_review, dependent: :destroy
end
