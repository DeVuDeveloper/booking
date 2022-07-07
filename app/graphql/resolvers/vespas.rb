# frozen_string_literal: true

module Resolvers
  module Vespas
    def bikes(id: nil)
      if id.present?
        ToptalReactBikesSchema.object_from_id(id, context)
      else
        Vespa.all
      end
    end
  end
end
