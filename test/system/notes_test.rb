# frozen_string_literal: true

require 'application_system_test_case'

# NotesTestはyjs-websocketを起動しながらテストをしてください
# https://github.com/yjs/y-websocket
# テスト走らせるたびにwebsokcetは起動し直す(ノートの更新状態を引き継いでしまうため)

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @reading_club = reading_clubs(:participating_club)

    # Websocket通信中は、各テストで利用するノートを変えてください(1つ前のテストのノート内容を引き継いでしまうため)
    @note1 = notes(:note1)
    @note2 = notes(:note2)
  end

  test 'create new note' do
    visit_with_auth(new_reading_club_note_path(@reading_club), @user)
    assert_text 'This is Participating Template'
    click_button 'ノートを新規作成'
    assert_text 'ノートを作成しました'
    assert_current_path overview_reading_club_path(@reading_club)
  end

  test 'update note' do
    visit_with_auth(edit_note_path(@note1), @user)
    assert_text "Content for note 1"

    fill_in 'note[title]', with: 'Updated Note Title'
    fill_in 'note[held_on]', with:  Date.new(2024, 2, 1)

    execute_script("document.querySelector('.ProseMirror').innerHTML = ''")
    execute_script("document.querySelector('.ProseMirror').innerHTML = 'Updated content for note 1'")

    click_button 'ノートを更新'
    assert_text 'ノートを更新しました'
    assert_text 'Updated content for note 1'
  end

  test 'apply template to note' do
    visit_with_auth(edit_note_path(@note2), @user)
    assert_text "Content for note 2"

    page.accept_confirm do
      click_button 'テンプレートを反映する'
    end

    assert_text 'ノートを更新しました'
    assert_text 'This is Opening Template'
  end
end
