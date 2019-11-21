class Validations
    @@REGEX_LOCATION = /^-{0,1}\d{1,3}(\.\d{1,}){0,1}$/
    @@NUMERIC = /^\d+$/
    
    def self.REGEX_LOCATION
        @@REGEX_LOCATION
    end

    def self.validate_search_by_distance(latitude, longitude, radius)
        if latitude.nil? or longitude.nil?
            errors = []
            if latitude.nil?
                errors.push(42)
            end
            if longitude.nil?
                errors.push(24)
            end
            return errors
        end
        validate_latitude = latitude =~ Validations.REGEX_LOCATION
        validate_longitude = longitude =~ Validations.REGEX_LOCATION
        validate_radius = radius.to_s =~ @@NUMERIC && radius.to_i <= 10
        
        errors = []

        if not validate_latitude or not validate_longitude or not validate_radius
            if not validate_latitude
                errors.push(40)
            end
            if not validate_longitude
                errors.push(41)
            end
            if not validate_radius
                errors.push(47)
            end
        end
        return errors
    end
end