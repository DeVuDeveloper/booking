# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeleteVespa' do
  let!(:bike) { create :bike }
  let(:bike_id) { ToptalReactVespasSchema.id_from_object(vespa, vespa.class, {}) }

  subject do
    context = { current_user: current_user }
    result = ToptalReactVespasSchema.execute(query_string, context: context, variables: variables)
    result.to_h['data']['deleteVespa']
  end

  let(:variables) do
    {
      "bikeId": vespa_id
    }
  end

  let(:query_string) do
    <<~GQL
      mutation DeletVespa($vespaId: ID!){
        deleteVespa(input: {vespaId: $vespaId}){
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
      end
    end
  end

  context 'positive cases' do
    context 'when authenticated' do
      let(:current_user) { create :user, :admin }

      it 'returns no error' do
        expect(subject['errors']).not_to be_present
      end

      it 'removed a vespa' do
        expect { subject }.to change { Vespa.count }.by(-1)
      end
    end
  end
end
