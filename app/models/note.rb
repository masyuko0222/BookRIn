# frozen_string_literal: true

class Note < ApplicationRecord
  validates :held_on, presence: true

  belongs_to :reading_club

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[title held_on]
    end
  end
end
