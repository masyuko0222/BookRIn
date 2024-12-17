class SetDefaultReadMeColumnOfReadingClub < ActiveRecord::Migration[7.1]
    DEF_READ_ME = <<~MARKDOWN
      # READ ME
      **輪読会のルールや読んで欲しいことを書きましょう！**

      ## 開催日時
      - 毎週月曜日 20:00~
      - 毎週水曜日 20:00~
      - 祝日はお休みです

      ## Discordリンク
      [リンク](https://example.com/)
    MARKDOWN

  def change
    change_column_default(:reading_clubs, :read_me, DEF_READ_ME)
  end
end
