# frozen_string_literal: true

require 'rails_helper'

describe Crud::Vespa::Update, type: :model do
  let(:params) { { id: vespa.id, color: ::Vespa::COLORS.last, longitude: 0, vespa_model_id: bike_model.id } }
  let(:current_user) { create :user, :admin }
  subject(:action) { described_class.as(current_user).new(params) }
  let!(:vespa_model) { create :vespa_model }
  let!(:vespa) { create :vespa }

  describe 'positive case' do
    it 'return the updated vespa' do
      expect do
        vespa = action.perform!
        expect(vespa.color).to eq(params[:color])
        expect(vespa.longitude).to eq(params[:longitude])
        expect(vespa.vespa_model_id).to eq(params[:vespa_model_id])
        expect(vespa.id).to eq(params[:id])
      end.to change { vespa.count }.by(0)
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
        it { is_expected.to validate_inclusion_of(:color).in_array(::Vespa::COLORS) }
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
