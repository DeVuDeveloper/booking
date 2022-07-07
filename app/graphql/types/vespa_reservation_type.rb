# frozen_string_literal: true

module Types
  class Vespa < Types::Base::Object
    description 'A Vespa reservation'

    field :id, ID, null: false
    field :start_date, GraphQL::Types::ISO8601DateTime, null: false,
                                                        description: 'The start_date of the reservation'
    field :end_date, GraphQL::Types::ISO8601DateTime, null: false,
                                                      description: 'The end date of the reservation'
    field :cancelled, Boolean, null: true,
                               description: 'The status of the reservation'
    field :user, ::Types::User, null: false,
                                description: 'The user who reserved the Vespa'
    field :Vespa, VespaType, null: false,
                             description: 'The Vespa which is reserved'
    field :rating, Integer, null: true,
                            description: 'The rating of the reservation'

    def user
      ::BatchLoaders::AssociationLoader.for(Reservation, :user).load(object)
    end

    def self.scope_items(items, context)
      ::ReservationPolicy::Scope.new(context[:current_user], items).resolve
    end
  end
end
