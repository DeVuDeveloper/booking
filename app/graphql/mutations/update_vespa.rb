# frozen_string_literal: true

module Mutations
  class UpdateVespa < Mutations::BaseMutation
    argument :color, ::Types::VespaColorsEnum, required: false
    argument :weight, Float, required: false
    argument :latitude, Float, required: false
    argument :longitude, Float, required: false
    argument :vespa_model_id, ID, required: false
    argument :vespa_id, ID, required: true, loads: ::Types::VespaType

    field :vespa, ::Types::VespaType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (updated_vespa = operation.perform)
        {
          bike: updated_vespa,
          errors: []
        }
      else
        {
          bike: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def authorized?(**args)
      return false, { errors: ["Can't update the bike with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def back_end_operation(vespa:, **args)
      return @back_end_operation if @back_end_operation.present?

      params = args.merge(id: vespa.first.id)
      if args[:vespa_model_id].present?
        params = params.merge(vespa_model_id: GraphQL::Schema::UniqueWithinType.decode(args[:vespa_model_id])[1])
      end
      @back_end_operation ||= Crud::Vespa::Update.as(context[:current_user]).new(params)
    end
  end
end
