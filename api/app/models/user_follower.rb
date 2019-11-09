class UserFollower < ApplicationRecord
    self.primary_keys = :user_login, :follower_user_login
end
