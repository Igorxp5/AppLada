class GameParticipant < ApplicationRecord
    self.primary_keys = :game_id, :user_login
    
    validates :game_id, presence: true
    validates :user_login, presence: true
    
    def joined_date
        time = will_go ? updated_at : created_at
        time.to_time.to_i
    end

    def game
        Game.find_by_id(game_id)
    end
end