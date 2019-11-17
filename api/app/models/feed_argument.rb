class FeedArgument < ApplicationRecord
    def parameter
        FeedParameter.find_by_id(feed_parameter_id)
    end

    def value_type
        parameter.value_type.to_sym
    end

    def key
        parameter.key
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
