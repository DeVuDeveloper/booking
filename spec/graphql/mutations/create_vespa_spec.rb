# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateVespa' do
  let(:vespa_model) { create :vespa_model }
  let(:vespa_model_id) { ToptalReactVespasSchema.id_from_object(vespa_model, vespa_model.class, {}) }
  subject do
    context = { current_user: current_user }
    result = ToptalReactVespasSchema.execute(query_string, context: context, variables: variables)
    result.to_h['data']['createBike']
  end

  let(:variables) do
    {
      "color": 'red',
      "weight": 3.5,
      "bikeModelId": vespa_model_id,
      "latitude": 23.15,
      "longitude": 35.38
    }
  end

  let(:query_string) do
    <<~GQL
      mutation createVespas($color: VespaColorsEnum!, $weight: Float!, $latitude: Float!, $longitude: Float!, $vespaModelId: ID!){
        createBike(input: {color: $color,
                           weight: $weight,
                           latitude: $latitude,
                           longitude: $longitude,
                           vespaModelId: $vespaModelId}){
          vespa {
            id,
            color,
            weight,
            model{
              id
            }
            latitude,
            longitude
          },
          errors,
        }
      }
    GQL
  end

  context 'negative cases' do
    context 'when not authenticated' do
      let(:current_user) { create :user }

      it 'returns an error' do
        expect(subject['errors']).to be_present
        expect(subject['vespa']).not_to be_present
      end
    end
  end

  context 'positive cases' do
    context 'when authenticated' do
      let(:current_user) { create :user, :admin }

      it 'returns vespa' do
        expect(subject['errors']).not_to be_present
        expect(subject['vespa']).to be_present
      end
    end
  end
end
