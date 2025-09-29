# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    association :user
    association :reading_club
  end
end
