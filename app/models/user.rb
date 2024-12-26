# frozen_string_literal: true

class User < ApplicationRecord
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
