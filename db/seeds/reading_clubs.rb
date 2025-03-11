# frozen_string_literal: true

if Rails.env.development?
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
end

if Rails.env.production?
  # 初めから参加しているサンプル輪読会
  sample_read_me = <<~MARKDOWN
    ### READ ME
      - この輪読会では、このREAD MEやノートを自由に触ってみましょう
      - 一通り触ってみたら、右上の「参加取消」から、輪読会の参加をやめることができます
        - いつでも再参加は可能です
  MARKDOWN
  
  ReadingClub.find_or_create_by!(title: 'サンプル輪読会') do |club|
    club.finished = false
    club.read_me = sample_read_me
    club.updated_at = Date.new(1900, 1, 1) # トップに表示されないよう古い日付
  end
end
