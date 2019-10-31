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
    
    args[:errors] = [args[:errors]] if args[:errors].instance_of? String
    args[:errors].uniq!
    args[:errors] = ErrorCodes.get_errors_by_messages(args[:errors])
    return {data: args[:payload], errors: args[:errors]}
  end

  protected

  def json_error_response
    self.status = 401
    self.content_type = "application/json"
    self.response_body = DeviseFailureApp.format_response(errors: i18n_message).to_json
  end

  def self.validate_response_errors(errors)
    raise_message = 'errors must be string or string list'
    unless errors.instance_of? String
      raise ArgumentError, raise_message unless errors.respond_to? :select
      if not errors.empty? and (errors.select {|s| s.instance_of? String}).empty?
        raise ArgumentError, raise_message
      end
    end
  end
end