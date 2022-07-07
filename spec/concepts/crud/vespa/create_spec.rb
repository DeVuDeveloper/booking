# frozen_string_literal: true

require 'rails_helper'

describe Crud::Vespa::Create, type: :model do
  let(:params) do
    { color: ::Vespa::COLORS.first, weight: 1.2, latitude: 0, longitude: 0, bike_model_id: vespa_model.id }
  end
  let(:current_user) { create :user, :admin }
  subject(:action) { described_class.as(current_user).new(params) }
  let!(:vespa_model) { create :vespa_model }

  describe 'positive case' do
    it 'returns the created vespa' do
      expect do
        vespa = action.perform!
        expect(vespa.color).to eq(params[:color])
        expect(vespa.weight).to eq(params[:weight])
        expect(vespa.latitude).to eq(params[:latitude])
        expect(vespa.longitude).to eq(params[:longitude])
      end.to change { vespa.count }.by(1)
    end
  end

  describe 'authorization' do
    context 'when unauthorized' do
      let(:current_user) { create :user }

      it { is_expected.to_not be_allowed }
    end
  end

  describe 'validations' do
    context 'attributes' do
      context 'color' do
        it { is_expected.to validate_presence_of(:color) }
        it { is_expected.to validate_inclusion_of(:color).in_array(::Vespa::COLORS) }
      end

      context 'latitude' do
        it { is_expected.to validate_presence_of(:latitude) }
        it { is_expected.to allow_value(1.2).for(:latitude) }
        it { is_expected.to_not allow_value('invalid latitude').for(:latitude) }
      end

      context 'longitude' do
        it { is_expected.to validate_presence_of(:longitude) }
        it { is_expected.to allow_value(1.2).for(:longitude) }
        it { is_expected.to_not allow_value('invalid longitude').for(:longitude) }
      end

      context 'weight' do
        it { is_expected.to validate_presence_of(:weight) }
        it { is_expected.to allow_value(1.2).for(:weight) }
        it { is_expected.to_not allow_value('invalid weight').for(:weight) }
      end
    end

    context 'vespa_model_id' do
      let(:params) { super().merge(vespa_model_id: -1) }

      it 'will be invalid' do
        action.valid?
        expect(action.errors[:vespa_model_id]).to be_present
      end
    end
  end
end
