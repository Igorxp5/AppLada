class TeamSubscription < ApplicationRecord 
    self.primary_keys = :team_initials, :user_login

    def joined_date
        super.to_time.to_i
    end
end