# frozen_string_literal: true

module Types
  class VespaColorsEnum < ::Types::Base::Enum
    Vespa::COLORS.each { |color| value color }
  end
end
