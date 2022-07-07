# frozen_string_literal: true

class VespaModel < ApplicationRecord
  has_many :vespas
  has_many :red_vespas, -> { red }, class_name: 'Vespa'
end
