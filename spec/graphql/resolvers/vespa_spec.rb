# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::Vespas, type: :query do
  before do
    @bike_resolver = create_temporary_class 'VespasResolver' do
      include Resolvers::Vespas

      def context
        {}
      end
    end
  end

  describe 'vespas' do
    subject { @vespa_resolver.new.vespas(params) }

    context 'when id is specified' do
      context 'when bike is found' do
        let(:params) { { id: ToptalReactBikesSchema.id_from_object(vespa_1, vespa_1.class, {}) } }
        let(:vespa_1) { create(:vespa, average_rating: 5) }
        let(:vespa_2) { create(:vespa, average_rating: 4) }

        it { is_expected.to include(vespa_1) }
        it { is_expected.to_not include(vespa_2) }
      end

      context 'when vespa is not found' do
        let(:params) { { id: ToptalReactVespasSchema.id_from_object(vespa_1, vespa_1.class, {}) } }
        let(:vespa_1) { build_stubbed(:vespa) }

        it { is_expected.to be_empty }
      end
    end

    context 'when id is not specified' do
      let(:params) { {} }
      let(:vespa_1) { create(:vespa, average_rating: 5) }
      let(:vespa_2) { create(:vespa, average_rating: 4) }

      it { is_expected.to include(vespa_1).and include(vespa_2) }
    end
  end
end
