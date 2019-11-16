class Society < ApplicationRecord
    attr_accessor :phones

    validates :name, presence: true, allow_blank: false, allow_nil: false, presence: true
    validates :latitude, presence: true, allow_blank: false, allow_nil: false, presence: true
    validates :longitude, presence: true, allow_blank: false, allow_nil: false, presence: true

    validate :validate_location
    validate :validate_phones
    
    after_initialize :retrieve_phones
    after_save :add_phones

    def validate_location
        if latitude.present? and not latitude =~ Validations.REGEX_LOCATION
            errors.add(:latitude, "is invalid")
        end
        if longitude.present? and not longitude =~ Validations.REGEX_LOCATION
            errors.add(:longitude, "is invalid")
        end
    end

    def validate_phones
        unless phones.instance_of? Array
            errors.add(:phones, "must be a array of phones")
        else
            phones.each do |phone|
                unless phone =~ /^\+\d{2}\d{2}\d{8,9}$/
                    errors.add(:phones, "is invalid. Phone format is: +5500111111111")
                end
            end
        end
        if latitude.present? and not latitude =~ Validations.REGEX_LOCATION
            errors.add(:latitude, "is invalid")
        end
        if longitude.present? and not longitude =~ Validations.REGEX_LOCATION
            errors.add(:longitude, "is invalid")
        end
    end

    def as_json(*)
        {
            id: id, name: name, latitude: latitude, longitude: longitude,
            description: description, phones: phones, rating: rating,
            current_tournament: current_tournament, owner: owner
        }
    end

    def phones=(value)
        @phones = value
    end

    def phones
        @phones
    end

    def current_tournament
        tournament = Tournament.find_by(society_id: id, finished: false)
        tournament.id unless tournament.nil?
    end
    
    def owner
        self.owner_user_login
    end

    def rating
        society_ratings = SocietyRating.where(society_id: id)
        total_votes = society_ratings.length
        ratings = society_ratings.collect {|society_rating| society_rating.rating}
        average = ratings.sum / total_votes rescue 0
        {average: average, total_votes: total_votes}
    end

    def tournaments
        Tournament.where(society_id: id).order(created_at: :desc)
    end

    def self.search_by_distance(center_latitude, center_longitude, radius=10)
        societies_sorted_distance = Society.all
            .select("*, 1.60934 * SQRT(POW(69.1 * (CAST(latitude AS FLOAT) - #{center_latitude}), 2)  + 
                    POW(69.1 * (#{center_longitude} - CAST(longitude AS FLOAT)) * COS(CAST(latitude AS FLOAT) / 57.3), 2)) AS distance")
            .order("distance DESC")
        Society
            .unscoped
            .select("*")
            .from(societies_sorted_distance, :societies_sorted_distance)
            .where("distance <= #{radius}")
    end

    private
    
    def add_phones
        # Remover todos os números de telefone anteriores
        SocietyPhone.where(society_id: id).delete_all

        phones.each do |phone|
            society_phone = SocietyPhone.create!(society_id: id, phone: phone)
        end
    end

    def retrieve_phones
        @phones = SocietyPhone.where(society_id: id).collect do |society_phone|
            society_phone.phone
        end
    end
end
