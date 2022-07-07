# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateVespa' do
  let(:vespa) { create :vespa }
  let(:vespa_id) { ToptalReactvespasSchema.id_from_object(vespa, vespa.class, {}) }

  subject do
    context = { current_user: current_user }
    result = ToptalReactVespasSchema.execute(query_string, context: context, variables: variables)
    result.to_h['data']['updateVespa']
  end

  let(:variables) do
    {
      "bikeId": vespa,
      "weight": 11
    }
  end

  let(:query_string) do
    <<~GQL
      mutation UpdateVespa($color: VespaColorsEnum, $weight: Float, $latitude: Float, $longitude: Float, $vespaModelId: ID, $vespaId: ID!){
        updateVespa(input: {color: $color,#{' '}
                           weight: $weight,
                           vespaModelId: $vespaModelId
                           latitude: $latitude,
                           longitude: $longitude,
                           vespaId: $vespaId}){
          vespa {
            id,
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
