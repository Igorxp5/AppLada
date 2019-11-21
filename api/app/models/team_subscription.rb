class TeamSubscription < ApplicationRecord 
    before_save :refresh_joined_date

    self.primary_keys = :team_initials, :user_login

    def as_json(*)
        result = {initials: team_initials, request_date: request_date, status: status, }
        result.merge!({joined_date: joined_date}) unless joined_date.nil?
        return result
    end


    def joined_date
        super.to_time.to_i unless super.nil?
    end

    def joined_date=(value)
        if value.instance_of? Date
            super(Time.at(value.to_time.to_i))
        elsif value.instance_of? Integer
            super(Time.at(value))
        else
            super(value)
        end
    end



    def request_date
        self.created_at.to_time.to_i
    end

    def status
        if self.accepted.nil?
            return "pending"
        elsif self.accepted 
            return "accepted"
        else
            return "refused"
        end

    end

    private
    def refresh_joined_date
        if self.accepted.nil? or not self.accepted
            self.joined_date = nil
        else
            self.joined_date = Time.now
        end
    end
end