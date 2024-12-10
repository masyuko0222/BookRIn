# frozen_string_literal: true

seeds = [
  Rails.root.join('db/seeds/reading_clubs.rb'),
  Rails.root.join('db/seeds/notes.rb')
]

seeds.each { |file| load(file) }
