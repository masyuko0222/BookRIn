# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 'discord' }
    sequence(:uid) { SecureRandom.uuid }
    sequence(:name) { |n| "User#{n}" }

    trait :alice do
      uid { '123e4567-e89b-12d3-a456-426614174000' }
      name { 'Alice' }
    end
  end
end
