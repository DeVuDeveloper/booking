# frozen_string_literal: true

module Bikes
  class Login < Grape::API
    helpers ::Helpers::ReturnFormatters

    format :json
    prefix :api

    desc 'Login.' do
      detail 'The session token is returned'
      params email: { required: true, type: 'String', desc: 'The email' },
             password: { required: true, type: 'String', desc: 'The password' }
      success ::Entities::Login::UserEntity
      failure [[400, 'Bad Parameters'],
               [401, 'Unauthenticated']]
    end
    post :login do
      action = ::Login::Action.as(:system).new(params)
      if action.valid?
        present action.perform, with: ::Entities::Login::UserEntity
      elsif action.errors[:email].include? 'Email is not registered'
        code = ErrorCodes::INVALID_USER_PWD
        message = action.errors[:email]
        details = action.errors.as_json
        http_return_code = 400

        return error!(error_custom(code, message, details).as_json, http_return_code)
      else
        code = ErrorCodes::INVALID_USER_PWD
        message = 'Email / Password do not match'
        details = action.errors.as_json
        http_return_code = 401

        return error!(error_custom(code, message, details).as_json, http_return_code)
      end
    end
  end
end
