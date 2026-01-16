# frozen_string_literal: true

class User < ApplicationRecord
  after_create :join_sample_reading_club

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :provider, presence: true

  has_many :participants, dependent: :destroy
  has_many :reading_clubs, through: :participants

  def participating?(reading_club)
    reading_clubs.include?(reading_club)
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[uid]
    end

    def ransackable_associations(_auth_object = nil)
      %w[participants reading_clubs]
    end

    def get_user_from(discord_info)
      uid = discord_info.uid
      provider = discord_info.provider
      name = discord_info.info.name

      user = find_or_create_by!(uid:, provider:) do |u|
        u.name = name
      end

      user.update!(name:) if user.name != name
      user
    end
  end

  private

  def join_sample_reading_club
    sample_titles = %w[
      参加中のサンプル輪読会1
      参加中のサンプル輪読会2
      参加中のサンプル輪読会3
    ]

    ReadingClub.where(title: sample_titles).find_each do |club|
      Participant.find_or_create_by!(user: self, reading_club: club)
    end
  end
end
