# frozen_string_literal: true

template = <<~MARKDOWN
  ## 学んだこと
  - Aさん
  - Bさん
  - Cさん

  ## その他
  - Aさん
  - Bさん
  - Cさん
MARKDOWN

read_me = <<~MARKDOWN
  # プログラミング基礎読書会

  **この読書会では、プログラミングの基礎を学びます。**

  - 開催日時: 毎週土曜日 午後2時〜午後4時

  ## 学習項目
  - 変数とデータ型
  - 条件分岐とループ
  - 基本的なアルゴリズム

  を中心に学習していきます。
  ぜひ一緒に学びましょう！

  [リンク](https://example.com/)
MARKDOWN

reading_clubs = [
  {
    title: 'プログラミング基礎読書会',
    finished: false,
    template:,
    read_me:,
    updated_at: Time.current
  },
  {
    title: '空の輪読会',
    finished: false,
    template: nil,
    read_me: nil,
    updated_at: Time.current
  }
]

reading_clubs.each do |reading_club|
  ReadingClub.find_or_create_by!(title: reading_club[:title]) do |club|
    club.assign_attributes(reading_club)
  end
end
