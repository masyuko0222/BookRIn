class SetDefaultTemplateColumnOfReadingClubs < ActiveRecord::Migration[7.1]
  DEF_TEMPLATE = <<~MARKDOWN
    ## これはテンプレート例です
      - 「テンプレート変更」から輪読会に合わせて変更してください

    ## 今日読んだ範囲
       - 「第〇章 p.xx」～「第〇章 p.yy」

    ## 学んだこと・分かったこと
      - Aさん
        - 〇〇というメソッドは、配列を△△したいときに利用する
      - Bさん
      - Cさん
      - Dさん

    ## ひとこと日記
      - Aさん
        - 最近は新しい海外ドラマを見始めました。めちゃくちゃ面白いです♪
      - Bさん
      - Cさん
      - Dさん
  MARKDOWN

  def up
    change_column_default(:reading_clubs, :template, DEF_TEMPLATE)
  end

  def down
    change_column_default(:reading_clubs, :template, nil)
  end
end
