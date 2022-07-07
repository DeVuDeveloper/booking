# frozen_string_literal: true

module Helpers
  module ReturnFormatters
    def format_action_errors(errors)
      code = ErrorCodes::INVALID_INPUT
      message = 'Bad Parameters'
      details = errors
      http_return_code = 400

      return_error(code, details, http_return_code, message)
    end

    def format_errors(result)
      if (key = result['result.policy.live']) && key.failure?
        code = ErrorCodes::ACCESS_DENIED
        message = 'Entity should be live.'
        http_return_code = 403
      elsif (key = result['result.policy.default']) && key.failure?
        code = ErrorCodes::ACCESS_DENIED
        message = 'Access Denied.'
        http_return_code = 403
      elsif (key = result['result.model']) && key.failure?
        code = ErrorCodes::RECORD_NOT_FOUND
        message = 'Record Not Found.'
        http_return_code = 404
      elsif result['result.contract.default'] && result['result.contract.default'].failure?
        code = ErrorCodes::INVALID_INPUT
        message = 'Bad Parameters'
        details = result['contract.default'].errors.as_json['errors']
        http_return_code = 400
      end

      return_error(code, details, http_return_code, message)
    end

    def error_custom(code, message, details)
      { error_code: code,
        error_message: message,
        details: details.as_json }
    end

    def error_from_system(code, msg)
      {
        error_code: code,
        error_message: msg
      }
    end

    def return_error(code, details, http_return_code, message)
      if details
        error!(error_custom(code, message, details).as_json, http_return_code)
      else
        error!(error_from_system(code, message).as_json, http_return_code)
      end
    end
  end
end
