class Rating < ApplicationRecord
  belongs_to :user

  def set_rate(points)
  	self.points += points
  	self.save
  end

end
