# frozen_string_literal: true

class Note < ApplicationRecord
  validates :held_on, presence: true

  belongs_to :reading_club

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[title content held_on]
    end

    def ransackable_associations(auth_object = nil)
      %w[reading_club]
    end
  end
end
