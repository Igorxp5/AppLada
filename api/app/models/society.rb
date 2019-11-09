class Society < ApplicationRecord
    # belongs_to :user, foreign_key: :owner_user_login

    # validates :name, presence: true
    # validates :description
    # validates :latitude, presence: true
    # validates :longitude, presence: true
    # validates :owner_user_login, presence: true
    
    def self.search_by_distance(center_latitude, center_longitude, radius=10)
        raise ArgumentError, 'radius must be less or equals than 10' if radius > 10
        societies_sorted_distance = Society.all
            .select("*, 1.60934 * SQRT(POW(69.1 * (latitude - #{center_latitude}), 2)  + 
                    POW(69.1 * (#{center_longitude} - longitude) * COS(latitude / 57.3), 2)) AS distance")
            .order("distance DESC")
        User
            .unscoped
            .select("*")
            .from(societies_sorted_distance, :societies_sorted_distance)
            .where("distance <= #{radius}")
    end
end
