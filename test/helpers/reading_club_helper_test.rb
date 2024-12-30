# frozen_string_literal: true

require 'test_helper'

class ReadingClubHelperTest < ActiveSupport::TestCase
  include ReadingClubHelper
  include ActionView::Helpers::SanitizeHelper

  # ほぼRedcarpet gemの挙動確認しているに等しいから、消してもいいかも。検討。
  test '.read_me_to_html convert to HTML from Markdown' do # rubocop:disable Metrics/BlockLength
    md_text = <<~MARKDOWN
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

    expected_html = <<~HTML
      <h1>プログラミング基礎読書会</h1>

      <p><strong>この読書会では、プログラミングの基礎を学びます。</strong></p>

      <ul>
      <li>開催日時: 毎週土曜日 午後2時〜午後4時</li>
      </ul>

      <h2>学習項目</h2>

      <ul>
      <li>変数とデータ型</li>
      <li>条件分岐とループ</li>
      <li>基本的なアルゴリズム</li>
      </ul>

      <p>を中心に学習していきます。
      ぜひ一緒に学びましょう！</p>

      <p><a href="https://example.com/">リンク</a></p>
    HTML

    assert_equal expected_html, read_me_to_html(md_text)
  end
end
