# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

100.times do |n|
  ReadingClub.create!(
    title: "OpeningTitle#{n + 1}",
    finished: false,
    read_me: "# Opening Club #{n + 1}\n\nThis is the **opening club** description in markdown format."
  )
end

100.times do |n|
  ReadingClub.create!(
    title: "FinishedTitle#{n + 1}",
    finished: true,
    read_me: "# Finished Club #{n + 1}\n\nThis is the **finished club** description in markdown format."
  )
end

User.create!(
  uid: 12345678, # rubocop:disable Style/NumericLiterals
  name: 'TestMan1',
  provider: 'discord'
)

User.create!(
  uid: 87654321, # rubocop:disable Style/NumericLiterals
  name: 'TestMan2',
  provider: 'discord'
)
