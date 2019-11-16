class Team < ApplicationRecord
    validates :initials, allow_blank: false, allow_nil: false, presence: true,  uniqueness: {case_sensitive: false}
    validates :name, allow_blank: false, allow_nil: false, presence: true,  uniqueness: {case_sensitive: false}
    before_save { self.name.downcase!}
    before_save {self.initials.upcase!}
    after_create :owner_subscription

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

    def owner_subscription
        puts(self.initials)
        @subscription = TeamSubscription.new(team_initials: self.initials, user_login: self.owner, accepted: true)
        @subscription.save
    end
end
