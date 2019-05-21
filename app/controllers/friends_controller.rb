class FriendsController < ApplicationController
	before_action :get_friend, only: :destroy

  def index
  	@friends = current_user.friends
    @count = current_user.received_requests.length
  end

  def destroy
    redirect_to :back unless @friend
    current_user.remove_friend(@friend)
    flash[:notice] = "Friend removed"
    redirect_to friends_path
  end

  def ranking
    @rating = current_user.rating
    @friends_rating = current_user.friends_rating
  end

  private

  def get_friend
    @friend = current_user.friends.find_by(id: params[:id])
  end
end
