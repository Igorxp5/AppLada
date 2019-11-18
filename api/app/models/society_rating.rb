class SocietyRating < ApplicationRecord
    self.primary_keys = :society_id, :user_login

    validates :rating, inclusion: { in: 0..5, message: 'Rating must be between 0 and 5' }

    def as_json(*)
        {
            login: user_login, avatar: user.avatar, level: user.level,
            rating: rating, comment: comment, date: date
        }
    end

    def date
        self.updated_at.to_time.to_i unless self.updated_at.nil?
    end

    def user
        User.find_by_login(user_login)
    end
end
