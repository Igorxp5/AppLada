class Match < ApplicationRecord
    @@STATUS = [:on_hold, :in_progress, :finished]

    validates :start_date, allow_blank: false, allow_nil: false, presence: true
    validates :duration, allow_blank: false, allow_nil: false, presence: true, numericality: {only_integer: true}

    validate :validate_start_date

    after_initialize :retrieve_teams
    after_initialize :retrieve_results
    before_save :set_match_order
    before_save :check_teams
    before_save :check_results
    after_save :add_teams
    after_save :add_result

    def validate_start_date
        if start_date.present?
            if start_date < Time.now.to_i
                errors.add(:start_date, "can't be in the past")
            end
            if start_date < tournament.start_date or start_date > tournament.end_date
                errors.add(:start_date, "match must be during tournament")
            end
        end
        
    end

    def as_json(*)
        {
            order: match_order, status: status,
            teams: teams, start_date: start_date,
            duration: duration, scoreboard: scoreboard,
            draw: draw?, winner: winner, looser: looser
        }
    end

    def status
        today = Time.now.to_i
        return 'on_hold' if today < start_date
        return 'in_progress' if today >= start_date and today < start_date + 1.days
        return 'finished'
    end

    def teams=(value)
        @teams = value.collect do |team_initials|
            # Must have a subscription
            TournamentSubscription.find_by!(tournament_id: tournament_id, team_initials: team_initials)
            Team.find_by_initials!(team_initials)
        end
        rescue ActiveRecord::RecordNotFound
            errors.add(:teams, "not found in tournament subscription")
            raise ArgumentError, 'Teams not found in tournament subscription'
    end

    def teams
        @teams
    end

    def scoreboard
        @scoreboard
    end

    def scoreboard=(value)
        valid = true
        if not value.respond_to?(:select) or value.size != 2
            valid = false
        else
            value.select do |point|
                valid = false unless point.instance_of? Integer
            end
        end
        if valid
            @scoreboard = value
        else
            errors.add(:scoreboard, "must be a 2-size integer list")
            raise ArgumentError
        end
    end
    
    def draw?
        @draw
    end
    
    def winner
        @winner
    end

    def winner=(value)
        TournamentSubscription.find_by!(tournament_id: tournament_id, team_initials: value)
        @winner = value
        rescue ActiveRecord::RecordNotFound
            errors.add(:winner, "not found in tournament subscription")
            raise ArgumentError
    end

    def looser
        @looser
    end

    def looser=(value)
        TournamentSubscription.find_by!(tournament_id: tournament_id, team_initials: value)
        @looser = value
        rescue ActiveRecord::RecordNotFound
            errors.add(:looser, "not found in tournament subscription")
            raise ArgumentError
    end
    
    def finished=(value)
        if not value
            @winner = nil
            @looser = nil
        end
        super(value)
    end

    def start_date
        super.to_time.to_i unless super.nil?
    end

    def start_date=(value)
        if value.instance_of? Date
            super(Time.at(value.to_time.to_i))
        elsif value.instance_of? Integer
            super(Time.at(value))
        else
            super(value)
        end
    end

    def self.STATUS
        return @@STATUS
    end

    def self.where_by_status(args={})
        raise ArgumentError, 'Invalid status value' unless @@STATUS.include?(args[:status])
        if args[:status] == :on_hold
            args.merge!(accepted: nil)
        elsif args[:status] == :in_progress
            args.merge!(accepted: true)
        elsif args[:status] == :finished
            args.merge!(accepted: false)
        end
        args.delete(:status)
        Match.where(args)
    end

    def tournament
        Tournament.find_by_id(tournament_id) if tournament_id
    end

    private

    def set_match_order
        if self.match_order.nil?
            self.match_order = Match.where(tournament_id: tournament_id).order(created_at: :asc).last.id + 1 rescue 1
        end
    end

    def check_teams
        unless @teams.size == 2
            errors.add(:teams, "must have two team initials")
            raise ArgumentError
        end
    end

    def check_results
        if not winner.nil? and winner == looser
            errors.add(:winner, "can't be equal looser")
        end

        if finished and (winner.nil? or looser.nil?)
            errors.add(:winner, "and Looser must be set if match has been finished")
        end

        if not finished and (not winner.nil? or not looser.nil?)
            errors.add(:winner, "and Looser can only be set if match has been finished")
        end

        unless errors.empty?
            raise ArgumentError
        end
    end

    def add_teams
        # Remover todos os números de telefone anteriores
        MatchParticipant.where(match_id: id).delete_all

        teams.each do |team|
            subscription = TournamentSubscription.find_by!(tournament_id: tournament_id, team_initials: team.initials)
            MatchParticipant.create!(match_id: id, tournament_subscription_id: subscription.id)
        end
    end

    def add_result
        result = MatchResult.find_or_initialize_by(match_id: id)
        winner_subscription = TournamentSubscription.find_by(tournament_id: tournament_id, team_initials: winner)
        looser_subscription = TournamentSubscription.find_by(tournament_id: tournament_id, team_initials: looser)
        if winner_subscription
            result.winner_tournament_subscription = winner_subscription.id
        end
        if looser_subscription
            result.looser_tournament_subscription = looser_subscription.id
        end
        unless scoreboard.nil?
            result.team_one_score = scoreboard[0]
            result.team_two_score = scoreboard[1]
        end
        result.save!
        retrieve_results
    end

    def retrieve_teams
        @teams = MatchParticipant.where(match_id: id).collect do |participant|
            subscription = TournamentSubscription.find_by_id!(participant.tournament_subscription_id)
            Team.find_by_initials!(subscription.team_initials)
        end
    end

    def retrieve_results
        @draw = nil
        result = MatchResult.find_by_match_id(id)
        if finished
            @draw = result.winner_tournament_subscription == nil
        end
        unless result.nil?
            @scoreboard = [result.team_one_score, result.team_two_score]
        end

        if not draw?.nil? and not draw?
            result = MatchResult.find_by_match_id!(id)
            @winner = TournamentSubscription.find_by_id!(result.winner_tournament_subscription).team_initials
            @looser = TournamentSubscription.find_by_id!(result.looser_tournament_subscription).team_initials
        end
    end
end
