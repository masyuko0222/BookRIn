# frozen_string_literal: true

class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true
  validates :provider, presence: true
end
