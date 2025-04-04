# frozen_string_literal: true

class Participant < ApplicationRecord
  validates :user_id, uniqueness: { scope: :reading_club_id }

  belongs_to :user
  belongs_to :reading_club
end
