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

# 以下はnoteの仮seed。そのうちきれいにする。
opening_club = ReadingClub.find_by(title: 'OpeningTitle100')

10.times do |n|
  opening_club.notes.create!(
    held_on: Time.zone.today - n,
    title: ((n % 3).zero? ? nil : "Note #{n + 1}"),
    content: case n % 4
             when 0, 2
               <<~MARKDOWN
                 ## 第#{n + 1}回
                 ### 読んだところ
                 - 「序章」から「第一章」まで
                 ### 疑問点や気づき、学んだこと
                 - **田中** 新しい視点で物事を見つめる大切さ
                 - **鈴木** 読みやすい構成の工夫
                 - **佐藤** 理解を深める質問が良い
                 ### 近況、今の気分など
                 - **高橋** 少し疲れ気味だが、読書が楽しい
                 - **山田** このクラブに参加できてよかった
                 - **中村** さらに次の章が楽しみ
               MARKDOWN
             when 1, 3
               nil # contentがnil
             end
  )
end
