# frozen_string_literal: true

FactoryBot.define do
  factory :reading_club do
    sequence(:title) { |n| "ReadingClub#{n}" }
    template { ReadingClub::DEFAULT_TEMPLATE }
    read_me { ReadingClub::DEFAULT_READ_ME }
    finished { false }

    trait :opening_club do
      title { 'OpeningClub' }
      template { 'This is Opening Template' }
      read_me { "# Welcome to Markdown\n\nThis is a **test**." }
    end
  end
end
