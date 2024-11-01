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

    def sort_participating_first(clubs, user)
      all_participating_clubs = user.participating_reading_clubs.order('participants.created_at DESC')
      sorted_clubs = clubs.sort_by(&:updated_at).reverse

      first_sorted_clubs = (all_participating_clubs & sorted_clubs).uniq(&:id)
      other_clubs = (sorted_clubs - all_participating_clubs)

      first_sorted_clubs + other_clubs
    end
  end
end
