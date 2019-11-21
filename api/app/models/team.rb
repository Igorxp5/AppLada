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
        @subscription = TeamSubscription.new(team_initials: self.initials, user_login: self.owner, accepted: true, joined_date: Time.now)
        @subscription.save
    end

    def tournament_subscriptions
        TournamentSubscription.where(team_initials: initials, accepted: true, banned: false)
    end

    def total_played_matches
        subs_id = tournament_subscriptions.collect {|subs| subs.id}
        MatchParticipant.where(tournament_subscription_id: subs_id).size
    end

    def total_win_matches
        subs_id = tournament_subscriptions.collect {|subs| subs.id}
        MatchResult.where(winner_tournament_subscription: subs_id).size
    end

    def total_played_tournaments
        tournament_subscriptions.size
    end

    def total_win_tournaments
        win_subscriptions = tournament_subscriptions.select do |subscription|
            TournamentRanking.find_by(ranking_position: 1, tournament_subscription_id: subscription.id)
        end
        win_subscriptions.size
    end

    def last_played_tournament
        subs_id = tournament_subscriptions.collect {|subs| subs.id}
        ranking = TournamentRanking.where(tournament_subscription_id: subs_id).order(updated_at: :desc)
        ranking.first.tournament_id if ranking.first
    end
end
