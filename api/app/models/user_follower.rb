class UserFollower < ApplicationRecord
    self.primary_keys = :user_login, :follower_user_login

    validates :user_login, presence: true
	validates :follower_user_login, presence: true
end
