class ChangeDefaultTemplateColumnOfReadingClubs < ActiveRecord::Migration[7.2]
  NEW_DEF_TEMPLATE = <<~MARKDOWN
    ### これはテンプレート例です
      - 「作成」ボタンを押して、新しいノートを作成しましょう！
      - 作成したノートは共同編集ができます。輪読会で学んだことをみんなで記録しましょう😀

    ### 今日読んだ範囲
       - 「第〇章 p.xx」～「第〇章 p.yy」

    ### 学んだこと・分かったこと
      - Aさん
        - 〇〇というメソッドは、配列を△△したいときに利用する
      - Bさん
  MARKDOWN

  def up
    change_column_default(:reading_clubs, :template, NEW_DEF_TEMPLATE)
    ReadingClub.update_all(template: NEW_DEF_TEMPLATE)
  end

  def down
    old_template = <<~MARKDOWN
      ### これはテンプレート例です
        - 「ノートを新規作成」ボタンを押して、新しいノートを作成しましょう！
        - 作成したノートは共同編集ができます。輪読会で学んだことをみんなで記録しましょう😀

      ### 今日読んだ範囲
         - 「第〇章 p.xx」～「第〇章 p.yy」

      ### 学んだこと・分かったこと
        - Aさん
          - 〇〇というメソッドは、配列を△△したいときに利用する
        - Bさん
        - Cさん
    MARKDOWN
    change_column_default(:reading_clubs, :template, old_template)
    ReadingClub.update_all(template: old_template)
  end
end
