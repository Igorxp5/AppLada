class DeviseFailureApp < Devise::FailureApp
  def http_auth_body
    json_error_response
  end

  def self.format_response(args = {})
    if not args[:errors].nil?
      validate_response_errors(args[:errors])
    else
      args[:errors] = []
    end
    
    if args[:errors].instance_of? String
      args[:errors] = [args[:errors]]
    elsif args[:errors].instance_of? Integer
      args[:errors] = [ErrorCodes.get_error_message(args[:errors])]
    end
    
    args[:errors].uniq!
    args[:errors] = args[:errors].collect do |message_or_code|
      if message_or_code.instance_of? String
        message = message_or_code
      elsif message_or_code.instance_of? Integer
        message = ErrorCodes.get_error_message(message_or_code)
      end
      ErrorCodes.get_error_by_message(message)
    end
    return {data: args[:payload], errors: args[:errors]}
  end

  protected

  def json_error_response
    self.status = 401
    self.content_type = "application/json"
    self.response_body = DeviseFailureApp.format_response(errors: i18n_message).to_json
  end

  def self.validate_response_errors(errors)
    raise_message = 'errors must be string, int, string list or int list'
    unless errors.instance_of? String or errors.instance_of? Integer
      raise ArgumentError, raise_message unless errors.respond_to? :select
      if not errors.empty? and (errors.select {|s| s.instance_of? String or s.instance_of? Integer}).empty?
        raise ArgumentError, raise_message
      end
    end
  end
end