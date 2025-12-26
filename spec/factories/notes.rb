# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    held_on { Date.new(2024, 1, 1) }
    sequence(:title) { |n| "サンプルノート #{n}" }
    sequence(:content) { |n| "Content for note #{n}" }
    created_at { Time.zone.local(2024, 1, 1) }
    updated_at { Time.zone.local(2024, 1, 1) }
    association :reading_club
  end
end
