# frozen_string_literal: true

require 'application_system_test_case'

class ReadMeTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @reading_club = reading_clubs(:reading_club_with_read_me)
  end

  test 'update read me' do
    visit_with_auth(reading_club_overview_path(@reading_club), @user)
    assert_current_path reading_club_overview_path(@reading_club)

    click_link '編集'
    fill_in 'reading_club[read_me]', with: "# Updated Markdown\n\nThis is the updated content."
    click_button '保存'
    assert_text 'READ MEを更新しました'
    assert_selector 'h1', text: 'Updated Markdown' # MarkdownなのでHTMLに変換される
  end
end
