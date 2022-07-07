# frozen_string_literal: true

require "rails_helper"

RSpec.describe VespaPolicy, type: :model do
  describe "scopes"

  describe "allowances" do
    subject { VespaPolicy.new(current_user, nil) }

    context "negative case" do
      let(:current_user) { create :user }

      it { is_expected.to_not permit_action(:create) }
    end

    context "positive case" do
      let(:current_user) { create :user, :admin }

      it { is_expected.to permit_action(:create) }
    end
  end
end
