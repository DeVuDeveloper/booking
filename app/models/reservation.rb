# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :vespa

  def live?
    !cancelled?
  end
end
