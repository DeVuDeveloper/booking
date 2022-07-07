# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include Resolvers::Vespas
    include Resolvers::Users

    field :available_vespas, VespaType.connection_type, null: false, connection: true,
                                                       description: 'A list of available vespas within the search parameters' do
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true
      argument :color, String, required: false
      argument :vespa_model_id, ID, required: false
      argument :weight, Float, required: false
      argument :rating, Integer, required: false
    end
    field :vespas, VespaType.connection_type, null: false, connection: true,
                                              description: 'A list of all vespas' do
      argument :id, ID, required: false
    end
    field :users, ::Types::User.connection_type, null: false, connection: true,
                                                 description: 'A list of all users' do
      argument :id, ID, required: false
    end
    field :vespas_models, [::Types::VespaModelType],
          null: false,
          description: 'A list of all vespas models'

    def vespas_models
      VespaModel.all
    end

    def available_bikes(**args)
      Queries::AvailableVespas.as(context[:current_user]).new(args).perform
    end
  end
end
