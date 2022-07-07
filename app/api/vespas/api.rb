# frozen_string_literal: true

module Vespas
  class API < Grape::API
    rescue_from :all do |e|
      binding.pry if Rails.env.development?
      # binding.pry if Rails.env.test?

      code = ErrorCodes::UNFORESEEN_SERVER_SIDE_ERROR
      message = 'Unforeseen Server Side Error Occured'
      http_return_code = 500

      rack_response(error_from_system(code, message).to_json, http_return_code)
    end

    mount Vespas::Signup

    mount Vespas::Login
    mount Vespas::Ping
    mount Vespas::Models
    mount Vespas::Vespas
    mount Vespas::Users
    mount Vespas::Reservations
    mount Vespas::Queries

    add_swagger_documentation
  end
end
