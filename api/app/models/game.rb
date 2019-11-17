class Game < ApplicationRecord
    attr_accessor :start_date
    attr_accessor :end_date

    validates :title, allow_blank: false, allow_nil: false, presence: true
    validates :start_date, allow_blank: false, allow_nil: false, presence: true
    validates :end_date, allow_blank: false, allow_nil: false, presence: true
    validates :latitude, allow_blank: false, allow_nil: false, presence: true
    validates :longitude, allow_blank: false, allow_nil: false, presence: true
    
    validate :validate_game_range
    validate :validate_location

    after_create :create_owner_participant

    def validate_game_range
        if start_date.present? and start_date < Date.today.to_time.to_i
            errors.add(:start_date, "can't be in the past")
        end

        if end_date.present? and end_date < Date.today.to_time.to_i
            errors.add(:end_date, "can't be in the past")
        end

        if start_date.present? and end_date.present? and end_date - start_date < 1.hours
            errors.add(:end_date, "must be at least one hour longer than start date")
        end
    end

    def validate_location
        if latitude.present? and not latitude =~ Validations.REGEX_LOCATION
            errors.add(:latitude, "is invalid")
        end
        if longitude.present? and not longitude =~ Validations.REGEX_LOCATION
            errors.add(:longitude, "is invalid")
        end
    end

    def as_json(*)
        {
            id: id, title: title, description: description, 
            latitude: latitude, longitude: longitude, 
            limit_participants: limit_participants, owner: owner,
            start_date: start_date, end_date: end_date, created_date: created_date
        }
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

    def end_date
        super.to_time.to_i unless super.nil?
    end

    def end_date=(value)
        if value.instance_of? Date
            super(Time.at(value.to_time.to_i))
        elsif value.instance_of? Integer
            super(Time.at(value))
        else
            super(value)
        end
    end

    def owner
        self.owner_user_login
    end

    def created_date
        self.created_at.to_time.to_i
    end

    def self.search_by_distance(center_latitude, center_longitude, radius=10)
        games_sorted_distance = Game.all
            .select("*, 1.60934 * SQRT(POW(69.1 * (CAST(latitude AS FLOAT) - #{center_latitude}), 2)  + 
                    POW(69.1 * (#{center_longitude} - CAST(longitude AS FLOAT)) * COS(CAST(latitude AS FLOAT) / 57.3), 2)) AS distance")
            .order("distance DESC")
        Game
            .unscoped
            .select("*")
            .from(games_sorted_distance, :games_sorted_distance)
            .where("distance <= #{radius}")
    end

    private

    def create_owner_participant
        participant = GameParticipant.new(game_id: id, user_login: owner, will_go: true)
        participant.save!
    end
end
