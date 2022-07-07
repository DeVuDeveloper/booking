# frozen_string_literal: true

module Mutations
  class DeleteVespa < Mutations::BaseMutation
    argument :bike_id, ID, required: true, loads: ::Types::VespaType

    field :errors, [String], null: false

    def authorized?(**_args)
      return false, { errors: ["Can't delete a vespa with the current role"] } unless context[:current_user].admin?

      true
    end

    def resolve(vespa:, **_rest)
      if vespa[0].destroy
        {
          errors: []
        }
      else
        {
          errors: ['An error occured.']
        }
      end
    end
  end
end
