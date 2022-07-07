# frozen_string_literal: true

require "rails_helper"

RSpec.describe VespaModel, type: :model do
  context "fields" do
    it { is_expected.to respond_to(:text) }
  end

  context "associations" do
    it { is_expected.to have_many(:vespas) }
  end
end
