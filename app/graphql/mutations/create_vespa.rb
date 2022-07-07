# frozen_string_literal: true

module Mutations
  class CreateVespa < Mutations::BaseMutation
    argument :color, ::Types::VespaColorsEnum, required: true
    argument :weight, Float, required: true
    argument :latitude, Float, required: true
    argument :longitude, Float, required: true
    argument :vespa_model_id, ID, required: true

    field :vespa, ::Types::VespaType, null: true
    field :errors, [String], null: false

    def authorized?(**args)
      return false, { errors: ["Can't create a vespa with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def resolve(**rest)
      operation = back_end_operation(rest)

      if operation.valid? && (vespa = operation.perform)
        {
          vespa: vespa,
          errors: []
        }
      else
        {
          vespa: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def back_end_operation(**args)
      params = args.merge(vespa_model_id: GraphQL::Schema::UniqueWithinType.decode(args[:vespa_model_id])[1])
      @back_end_operation ||= Crud::Vespa::Create.as(context[:current_user]).new(params)
    end
  end
end
