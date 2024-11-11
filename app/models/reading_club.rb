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

    def ransackable_associations(_auth_object = nil)
      %w[notes participants users]
    end

    def sort_by_participations(clubs, user, is_requested_open:)
      if is_requested_open
        sort_participating_first(clubs, user)
      else
        clubs.order(created_at: :desc)
      end.to_a
    end

    private

    def sort_participating_first(clubs, user)
      user_participating_clubs = user.participating_reading_clubs
                                     .where(id: clubs.pluck(:id))
                                     .order('participants.created_at DESC')
                                     .to_a

      non_participating_clubs = (clubs - user_participating_clubs).sort_by(&:updated_at).reverse

      user_participating_clubs + non_participating_clubs
    end
  end
end
