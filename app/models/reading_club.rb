# frozen_string_literal: true

class ReadingClub < ApplicationRecord
  validates :title, presence: true
  validates :finished, inclusion: { in: [true, false] }

  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  has_many :notes, dependent: :destroy

  scope :finished, -> { where(finished: true) }
  scope :open, -> { where(finished: false) }

  paginates_per 15

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[title finished]
    end

    def opening_clubs_participated_by(user)
      ReadingClub.open
                 .joins(:participants)
                 .where(participants: { user_id: user.id })
                 .order('participants.updated_at DESC')
    end
  end
end
