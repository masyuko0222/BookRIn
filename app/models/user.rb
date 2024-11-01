# frozen_string_literal: true

class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :provider, presence: true

  has_many :participants, dependent: :destroy
  has_many :participating_reading_clubs, through: :participants, source: :reading_club

  class << self
    def find_or_create_from_discord_info(discord_info)
      user_info = user_discord_info(discord_info)

      where(user_info).first_or_create(user_info)
    end

    private

    def user_discord_info(discord_info)
      {
        uid: discord_info.uid,
        name: discord_info.info.name,
        provider: discord_info.provider
      }
    end
  end
end
