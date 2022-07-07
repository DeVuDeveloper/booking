# frozen_string_literal: true

require 'rails_helper'

describe 'vespa API endpoints' do
  let(:session_token) { 'token-xxx123123' }
  let!(:user) { create :user, :admin, hashed_session_token: User.pwd_hash(session_token) }
  let(:developer_header) { { 'X-Auth-Token' => session_token } }

  context 'creates a vespa' do
    let(:vespa_model) { create :vespa_model }
    let(:params) do
      { color: ::Vespa::COLORS.first, weight: 12, latitude: 12.5, longitude: 13.6, vespa_model_id: vespa_model.id }
    end
    let(:path) { '/api/vespas' }
    subject { post path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'

      context 'invalid params' do
        context 'color' do
          let(:params) { super().merge color: 'Invalid Color' }

          specify 'Returns Bad Request' do
            expect_bad_request
            expect_json
          end
        end

        context 'vespa_model_id' do
          let(:params) { super().merge vespa_model_id: -1 }

          specify 'Returns unauthorized' do
            expect_bad_request
            expect_json
          end
        end
      end
    end

    context 'positive cases' do
      specify 'Returns created' do
        expect_created
        expect_json
        expect_contains_field('id')
        expect_contains_field('vespa_model_id')
      end
    end
  end

  context 'returns all the vespas' do
    let!(:vespa_1) { create :vespa }
    let!(:vespa_2) { create :vespa }
    let(:params) { {} }
    let(:path) { '/api/vespas' }
    subject { get path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'
    end

    context 'positive cases' do
      specify 'Returns success' do
        expect_success
        expect_json
        expect_first_in_the_array_includes('id')
        expect_first_in_the_array_includes('vespa_model_id')
      end
    end
  end

  context 'reservations of a vespa' do
    let!(:reservation) { create :reservation, vespa: vespa }
    let(:vespa) { create :vespa }
    let(:params) { {} }
    let(:path) { "/api/vespas/#{vespa.id}/reservations" }
    subject { get path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'
    end

    context 'positive cases' do
      specify 'Returns success' do
        expect_success
        expect_json
        expect_first_in_the_array_includes('id')
        expect_first_in_the_array_includes('rating')
      end
    end
  end

  context 'returns a vespa' do
    let(:vespa) { create :vespa }
    let(:params) { {} }
    let(:path) { "/api/vespas/#{vespa.id}" }
    subject { get path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'
    end

    context 'positive cases' do
      specify 'Returns success' do
        expect_success
        expect_json
        expect_contains_field('id')
        expect_contains_field('vespa_model_id')
      end
    end
  end

  context 'deletes a vespa' do
    let(:vespa) { create :vespa }
    let(:params) { {} }
    let(:path) { "/api/vespas/#{vespa.id}" }
    subject { delete path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'
    end

    context 'positive cases' do
      specify 'Returns success' do
        expect_success
        expect_json
        expect_contains_field('id')
        expect_contains_field('vespa_model_id')
      end
    end
  end

  context 'updates a vespa' do
    let(:vespa) { create :vespa }
    let(:params) { {} }
    let(:path) { "/api/vespas/#{vespa.id}" }
    subject { put path, params: params, headers: developer_header }

    context 'negative cases' do
      it_behaves_like 'unauthenticated'

      context 'invalid params' do
        context 'color' do
          let(:params) { super().merge color: 'Invalid Color' }

          specify 'Returns unauthorized' do
            expect_bad_request
            expect_json
          end
        end

        context 'vespa_model_id' do
          let(:params) { super().merge vespa_model_id: -1 }

          specify 'Returns unauthorized' do
            expect_bad_request
            expect_json
          end
        end
      end
    end

    context 'positive cases' do
      specify 'Returns success' do
        expect_success
        expect_json
        expect_contains_field('id')
        expect_contains_field('vespa_model_id')
      end
    end
  end
end
