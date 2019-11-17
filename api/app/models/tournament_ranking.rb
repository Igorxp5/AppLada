class TournamentRanking < ApplicationRecord
    self.primary_keys = [:tournament_id, :ranking_position]
    
    validates :tournament_subscription_id, allow_blank: false, allow_nil: false, presence: true
    validates :ranking_position, allow_blank: false, allow_nil: false, presence: true

    def as_json(*)
        result = {ranking_position: ranking_position}
        result.merge(team.as_json)
    end

    def team_initials
        subscription = TournamentSubscription.find_by_id!(tournament_subscription_id)
        subscription.team_initials
    end

    def team
        subscription = TournamentSubscription.find_by_id!(tournament_subscription_id)
        Team.find_by_initials!(subscription.team_initials)
    end

    def self.set_tournament_ranking(tournament_id, teams_initials)
        unless teams_initials.respond_to? :select and teams_initials.respond_to? :each
            raise ArgumentError, ErrorCodes.get_error_message(85)
        end

        tournament_teams_initials = Tournament.find_by_id(tournament_id).teams.collect do |team|
            team.initials
        end
        
        if teams_initials.size != tournament_teams_initials.size
            raise ArgumentError, ErrorCodes.get_error_message(86)
        end

        tournament_teams_initials.each do |team|
            raise ArgumentError, ErrorCodes.get_error_message(86) unless teams_initials.include? team
        end

        TournamentRanking.transaction do
            TournamentRanking.delete_tournament_ranking(tournament_id)
            ranking_position = 1
            teams_initials.each do |team|
                subscription = TournamentSubscription.find_by!(tournament_id: tournament_id, team_initials: team)
                ranking = TournamentRanking.create!(tournament_id: tournament_id,
                                                    ranking_position: ranking_position, 
                                                    tournament_subscription_id: subscription.id)
                ranking_position += 1
            end
        end
    end

    def self.delete_tournament_ranking(tournament_id)
        TournamentRanking.where(tournament_id: tournament_id).delete_all
    end

    def self.tournament_ranking(tournament_id)
        rankings = TournamentRanking.where(tournament_id: tournament_id).order(ranking_position: :asc)
        rankings.collect do |ranking|
            subscription = TournamentSubscription.find_by_id(ranking.tournament_subscription_id)
            subscription.team_initials
        end
        winner = rankings.size > 0 ? rankings[0] : nil
        {winner: winner, ranking: rankings}
    end
end
