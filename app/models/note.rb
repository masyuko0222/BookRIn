# frozen_string_literal: true

class Note < ApplicationRecord
  validates :held_on, presence: true

  belongs_to :reading_club
end
