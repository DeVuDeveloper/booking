# frozen_string_literal: true

module Vespas
  class Vespas < Grape::API
    helpers ::Helpers::ApiAuthenticationHelper
    helpers ::Helpers::OperationAdapter
    before { authenticate! }

    format :json
    prefix :api

    namespace :vespas do
      desc 'Creates a vespa.' do
        detail 'Returns a vespa'
        success ::Entities::BikeEntity
        failure [[401, 'Unauthenticated'],
                 [400, 'Bad Request']]
        headers 'X-Auth-Token': {
          description: 'The authentication token',
          required: true
        }
      end
      post do
        call_action(::Crud::Vespa::Create, params, default_additional_params) do |result|
          present result, with: ::Entities::VespaEntity
        end
      end

      desc 'Vespa.' do
        detail 'Returns the vespas'
        success ::Entities::BikeEntity
        failure [[401, 'Unauthenticated']]
        headers 'X-Auth-Token': {
          description: 'The authentication token',
          required: true
        }
      end
      get do
        present Vespa.all, with: ::Entities::VespaEntity
      end

      route_param :id do
        desc 'Reservation for a Vespa.' do
          detail 'Returns the reservations for the vespas.'
          success ::Entities::ReservationEntity
          failure [[401, 'Unauthenticated'],
                   [404, 'Not found']]
          headers 'X-Auth-Token': {
            description: 'The authentication token',
            required: true
          }
        end
        get :reservations do
          call_action(::Crud::Common::Read, params.merge(ar_class: :vespa), default_additional_params) do |model|
            present model.reservations, with: ::Entities::ReservationEntity
          end
        end

        desc 'Vespa.' do
          detail 'Returns a vespas'
          success ::Entities::BikeEntity
          failure [[401, 'Unauthenticated'],
                   [404, 'Not found']]
          headers 'X-Auth-Token': {
            description: 'The authentication token',
            required: true
          }
        end
        get do
          call_action(::Crud::Common::Read, params.merge(ar_class: :vespa), default_additional_params) do |model|
            present model, with: ::Entities::VespaEntity
          end
        end

        desc 'Deletes a vespa.' do
          detail 'Returns a vespas'
          success ::Entities::VespaEntity
          failure [[401, 'Unauthenticated'],
                   [404, 'Not found']]
          headers 'X-Auth-Token': {
            description: 'The authentication token',
            required: true
          }
        end
        delete do
          call_action(::Crud::Common::Delete, params.merge(ar_class: :vespa), default_additional_params) do |model|
            present model, with: ::Entities::VespaEntity
          end
        end

        desc 'Updates a vespa.' do
          detail 'Returns a vespas'
          success ::Entities::BikeEntity
          failure [[401, 'Unauthenticated'],
                   [404, 'Not found'],
                   [400, 'Bad Request']]
          headers 'X-Auth-Token': {
            description: 'The authentication token',
            required: true
          }
        end
        put do
          call_action(::Crud::Vespa::Update, params, default_additional_params) do |result|
            present result, with: ::Entities::VespaEntity
          end
        end
      end
    end
  end
end
