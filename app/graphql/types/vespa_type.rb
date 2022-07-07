# frozen_string_literal: true

module Types
  class VespaType < Types::Base::Object
    description 'A rentable bike'

    field :id, ID, null: false
    field :color, VespaColorsEnum, null: true,
                                   description: 'The color of the Vespa'
    field :weight, Float, null: true,
                          description: 'The weight of a Vespa in kg'
    field :latitude, Float, null: true,
                            description: 'The latitude of the current position of the Vespa'
    field :longitude, Float, null: true,
                             description: 'The longitude of the current position of the Vespa'
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :average_rating, Float, null: true,
                                  description: 'The average rating of the Vespa'
    field :model, VespaModelType, null: true,
                                  method: :Vespa_model,
                                  description: 'The model of the Vespa'
    field :reservations, [VespaReservationType], null: true,
                                                 description: 'The reservations of the Vespa'
    field :image_url, String, null: true,
                              description: 'The url of the image presenting the Vespa'

    def image_url
      if object.picture.attachment.present?
        Rails.application.routes.url_helpers.rails_blob_path(object.picture, only_path: true)
      end
    end

    def model
      ::BatchLoaders::AssociationLoader.for(vespa, :vespa_model).load(object)
    end

    def reservations
      ::BatchLoaders::AssociationLoader.for(vespa, :reservations).load(object)
    end
  end
end
