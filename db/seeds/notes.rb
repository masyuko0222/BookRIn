# frozen_string_literal: true

reading_club = ReadingClub.find_by(title: 'プログラミング基礎読書会')

start_date = Time.zone.today - 26 * 7 # 半年前
end_date = Time.zone.today
(start_date..end_date).step(7).each_with_index do |held_on, i|
  title = "第#{i + 1}回 今日はXXXを学んだ"
  content = <<~MARKDOWN
    ## 学んだこと
    - **Aさん**: 「変数について」
      - > 変数はローカル変数、インスタンス変数、グローバル変数などなどがある
      - とてもためになりました
    - **Bさん**: 「データ型について」
      - **暗黙の変換**もしてくれるが、ちゃんと自分で型を把握できるようにしたいと思った。
    - **Cさん**:
      - 以下のコードがお気に入りです。
      ```ruby
      # Rubyコードの例
      def example_method
        puts "Hello"
      end
      ```

    ## その他
    - **ディスカッション**: 次回の進め方について
    - **課題の共有**: JavaScriptの基にした個人プロジェクトを進めます。
  MARKDOWN

  Note.create!(
    held_on:,
    title:,
    content:,
    reading_club_id: reading_club.id,
    created_at: Time.zone.parse(held_on.to_s),
    updated_at: Time.zone.parse(held_on.to_s)
  )
end
