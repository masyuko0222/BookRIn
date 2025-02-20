# frozen_string_literal: true

reading_clubs = [
  {
    title: 'プログラミング基礎読書会',
    finished: false,
    updated_at: Date.new(2025, 1, 1)
  },
  {
    title: '終わった輪読会',
    finished: true,
    updated_at: Date.new(2024, 12, 1)
  }
]

40.times do |i|
  reading_clubs << {
    title: "空の輪読会#{i + 1}",
    finished: false,
    updated_at: Date.new(2024, 12, 1)
  }
end

reading_clubs.each do |reading_club|
  ReadingClub.find_or_create_by!(title: reading_club[:title]) do |club|
    club.assign_attributes(reading_club)
  end
end
