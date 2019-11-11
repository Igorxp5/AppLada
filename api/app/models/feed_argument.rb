class FeedArgument < ApplicationRecord
    self.primary_keys = :feed_id, :key

    def value_type
        FeedParameter.find_by(feed_type: feed_type, key: key).value_type.to_sym
    end

    def value
        if value_type == :integer
            super.to_i
        elsif value_type == :float
            super.to_f
        elsif value_type == :string
            super.to_s
        end
    end
end
