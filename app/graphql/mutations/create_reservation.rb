# frozen_string_literal: true

module Mutations
  class CreateReservation < Mutations::BaseMutation
    argument :start_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_date, GraphQL::Types::ISO8601Date, required: true
    argument :vespa_id, ID, required: true, loads: ::Types::BikeType

    field :reservation, ::Types::VespaReservationType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (model = operation.perform)
        {
          reservation: model,
          errors: []
        }
      else
        {
          reservation: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def authorized?(**args)
      unless back_end_operation(args).allowed?
        return false, { errors: ["Can't create the reservation with the current role"] }
      end

      true
    end

    def back_end_operation(bike:, **args)
      @back_end_operation ||= Crud::Reservation::Create.as(context[:current_user]).new(args.merge(current_user: context[:current_user]).merge(vespa_id: vespa[0].id))
    end
  end
end
