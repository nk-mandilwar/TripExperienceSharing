class Rating < ApplicationRecord
  belongs_to :user

  def set_rate(params)
  	points = 0
  	points += 1 if params[:rating].present?
  	points += 1 if params[:feedback].present?
  	self.points += points
  	self.save
  end

end
