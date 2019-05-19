class FriendRequestsController < ApplicationController

	before_action :get_friend_request, only: [:destroy, :update]

	def index
  	@incoming = current_user.received_requests
	end

  def create
    @friend_request = current_user.friend_requests.new(friend_id: params[:friend_id] )
    @friend_request.save
    @user = User.find_by(id: @friend_request.friend_id)
    flash[:notice] = "Friend request sent."
    redirect_to users_path
  end

  def destroy
    redirect_path = @friend_request.blank? ? users_path : friend_requests_path
    @friend_request ||= FriendRequest.find_by(friend_id: params[:id])
    @user = User.find_by(id: @friend_request.friend_id)
    redirect_to :back unless @friend_request
    if @friend_request.user_id != current_user.id && @friend_request.friend_id != current_user.id
      @notice = "You can't reject the request that you didnt send or receive."
    else
    	@friend_request.destroy
    end
    flash[:notice] = "Friend request removed"
    redirect_to redirect_path
  end

  def update
    redirect_to :back unless @friend_request
    if @friend_request.friend_id != current_user.id
      @notice = "You can't accept the request that you didnt receive."
    else
  	  @friend_request.accept
    end
    flash[:notice] = "Friend request accepted"
    redirect_to friend_requests_path
	end

  private

  def get_friend_request
    @friend_request = FriendRequest.find_by(user_id: params[:id])
  end
end