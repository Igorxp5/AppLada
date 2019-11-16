class Tournament < ApplicationRecord

    validates :title, allow_blank: false, allow_nil: false, presence: true
    validates :society_id, allow_blank: false, allow_nil: false, presence: true
    validates :start_date, allow_blank: false, allow_nil: false, presence: true
    validates :end_date, allow_blank: false, allow_nil: false, presence: true
    validates :end_subscription_date, allow_blank: false, allow_nil: false, presence: true
    validates :teams_limit, allow_blank: false, allow_nil: false, presence: true, numericality: { only_integer: true }
    validates :price, presence: false, allow_blank: false, allow_nil: true, numericality: {only_float: true}
    
    validate :validate_society_id
    validate :validate_tournament_range

    def validate_society_id
        if society_id.present?
            errors.add(:society_id, "don't exist") if society.nil?
        end
    end

    def validate_tournament_range
        if start_date.present? and start_date < Date.today.to_time.to_i
            errors.add(:start_date, "can't be in the past")
        end

        if end_date.present? and end_date < Date.today.to_time.to_i
            errors.add(:end_date, "can't be in the past")
        end

        if start_date.present? and end_date.present? and end_date - start_date < 1.days
            errors.add(:end_date, "must be at least one day longer than start date")
        end

        if start_date.present? and end_subscription_date.present? and end_subscription_date > start_date
            errors.add(:end_subscription_date, "must be before start date")
        end
        if start_date.present? and end_subscription_date.present? and start_date - end_subscription_date < 1.hours
            errors.add(:start_date, "must be at least one hour longer than end subscription date")
        end
    end

    def as_json(*)
        {
            id: id, society_id: society_id, title: title, description: description,
            price: price, teams_limit: teams_limit, status: status, 
            start_date: start_date, end_date: end_date, 
            end_subscription_date: end_subscription_date, created_date: created_date
        }
    end
    
    def created_date
        self.created_at.to_time.to_i unless self.created_at.nil?
    end

    def status
        today = Date.today.to_time.to_i
        return 'register_period' if today < end_subscription_date
        return 'on_hold' if today < start_date
        return 'in_progress' if today >= start_date and today < end_date
        return 'finished'
    end

    def society
        Society.find_by_id(society_id)
    end

    def start_date
        super.to_time.to_i unless super.nil?
    end

    def start_date=(value)
        if value.instance_of? Date
            super(Time.at(value.to_i))
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
            super(Time.at(value.to_i))
        elsif value.instance_of? Integer
            super(Time.at(value))
        else
            super(value)
        end
    end

    def end_subscription_date
        super.to_time.to_i unless super.nil?
    end

    def end_subscription_date=(value)
        if value.instance_of? Date
            super(Time.at(value.to_i))
        elsif value.instance_of? Integer
            super(Time.at(value))
        else
            super(value)
        end
    end

    def self.search_by_distance(center_latitude, center_longitude, radius=10)
        nearby_societies = Society.search_by_distance(center_latitude, center_longitude, radius)
        nearby_societies.select {|society| society.current_tournament}
        nearby_societies.collect do |society|
            Tournament.find_by_id(society.current_tournament)
        end
    end
end
