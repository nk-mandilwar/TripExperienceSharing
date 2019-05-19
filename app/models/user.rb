class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friend_requests, foreign_key: "user_id", dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest",
                               foreign_key: "friend_id",
                               dependent: :destroy

  has_many :requests, through: :friend_requests, source: :friend
  has_many :received_requests, through: :received_friend_requests, source: :user                           

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  
  def remove_friend(friend)
    self.friends.destroy(friend)
    friend.friends.destroy(self)
  end

  def self.fetch_unfriend_users(user_id)
    joins("left outer join friendships F ON F.user_id = users.id AND F.friend_id = #{user_id} OR F.user_id = #{user_id}
      left outer join friend_requests FR ON FR.user_id = users.id AND FR.friend_id = #{user_id}
      left outer join friend_requests FR2 ON FR2.friend_id = users.id AND FR2.user_id = #{user_id}").
    where("F.user_id is null AND FR.user_id is null AND FR2.friend_id is null AND users.id != #{user_id}")
  end
                             
end
