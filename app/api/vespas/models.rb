# frozen_string_literal: true

module Vespas
  class Models < Grape::API
    helpers ::Helpers::ApiAuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    desc 'Models.' do
      detail 'Return the models'
      success ::Entities::VespaModelEntity
      failure [[401, 'Unauthenticated']]
      headers 'X-Auth-Token': {
        description: 'The authentication token',
        required: true
      }
    end
    get :vespa_models do
      present VespaModel.all, with: ::Entities::VespaModelEntity
    end
  end
end
