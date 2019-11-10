class Team < ApplicationRecord

    validates :initials, allow_blank: false,allow_nil: false, presence: true,  uniqueness: {case_sensitive: false}
    validates :name, allow_blank: false, allow_nil: false, presence: true,  uniqueness: {case_sensitive: false}
    

    def as_json(*)
        {
         initials: initials, name: name, avatar: avatar, 
         owner: owner, created_date: created_date
        }
    end


    def members
        subscriptions = TeamSubscription.where(team_initials: initials, accepted: true, banned: false)
        subscriptions = subscriptions.collect do |subscription|
            subscription.user_login
        end
        subscriptions.push owner
        subscriptions
    end
    
    def created_date
        self.created_at.to_time.to_i
    end

    def owner
        self.owner_user_login
    end

    def owner=(value)
        self.owner_user_login = value
    end
end