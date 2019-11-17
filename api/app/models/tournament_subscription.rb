class TournamentSubscription < ApplicationRecord
    @@STATUS = [:pending, :accepted, :refused]
    
    before_save :refresh_joined_date

    def as_json(*)
        result = {
            team_initials: team_initials, request_date: request_date, status: status
        }
        result.merge!({joined_date: joined_date}) unless joined_date.nil?
        return result
    end

    def status
        return 'pending' if self.accepted.nil?
        return self.accepted ? 'accepted' : 'refused' 
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
        self.created_at.to_time.to_i unless self.created_at.nil?
    end

    def self.STATUS
        return @@STATUS
    end

    def self.where_by_status(args={})
        raise ArgumentError, 'Invalid status value' unless @@STATUS.include?(args[:status])
        if args[:status] == :pending
            args.merge!(accepted: nil)
        elsif args[:status] == :accepted
            args.merge!(accepted: true)
        elsif args[:status] == :refused
            args.merge!(accepted: false)
        end
        args.delete(:status)
        TournamentSubscription.where(args)
    end

    private

    def refresh_joined_date
        if self.accepted.nil? or not self.accepted
            self.joined_date = nil
        else
            self.joined_date = Date.today
        end
    end
end
