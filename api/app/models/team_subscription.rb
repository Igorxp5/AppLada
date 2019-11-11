class TeamSubscription < ApplicationRecord 
    self.primary_keys = :team_initials, :user_login

    def as_json(*)
        {initials: team_initials, request_date: request_date, status: status}
    end


    def joined_date
        super.to_time.to_i unless super.nil?
    end

    def request_date
        self.created_at.to_time.to_i
    end

    def status
        "pending"
    end
end