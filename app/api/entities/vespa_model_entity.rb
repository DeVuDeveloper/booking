# frozen_string_literal: true

module Entities
  class VespaModelEntity < Grape::Entity
    expose :id
    expose :text
  end
end
