class Feed < ApplicationRecord

    def as_json(*)
        {login: user_login, action_type: action_type, action_data: action_data, date: date}
    end

    def action_type
        self.feed_type
    end
    
    def action_data
        data = Hash.new
        arguments.select do |argument|
            data[argument.key] = argument.value
        end
        return data
    end

    def date
        self.created_at.to_time.to_i unless self.created_at.nil?
    end

    def parameters
        Feed.feed_type_parameters(feed_type)
    end
    
    def arguments
        FeedArgument.where(feed_id: id)
    end

    def self.new_feed(type, user_login, args={})
        parameters = Feed.feed_type_parameters(type)
        Feed.transaction do
            feed = Feed.create!(user_login: user_login, feed_type: type.to_s)
            arguments = []
            parameters.select do |id, key, value_type|
                argument = FeedArgument.new(feed_id: feed.id, 
                                            feed_parameter_id: id,
                                            value: args[key.to_sym])
                arguments.push(argument)
            end
            arguments.select do |argument|
                argument.save!
            end
        end
    end

    def self.feed_type_parameters(type)
        parameters = FeedParameter.where(feed_type: type)
        parameters.collect do |parameter|
            [parameter.id, parameter.key, parameter.value_type]
        end
    end
end