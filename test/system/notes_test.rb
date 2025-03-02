# frozen_string_literal: true

require 'application_system_test_case'

# NotesTestはyjs-websocketを起動しながらテストをしてください
# `HOST=localhost PORT=5678 npx y-websocket` https://github.com/yjs/y-websocket
# Websocket起動中は最後に編集された内容を保持してしまうので、テスト毎に起動しなおしてください

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @reading_club = reading_clubs(:participating_club)

    # Websocket通信中は、各テストで利用するノートを変える
    # Websocket起動中は最後に編集された内容を保持してしまうため
    @note1 = notes(:note1)
    @note2 = notes(:note2)
    @note3 = notes(:note3)
  end

  test 'create new note' do
    visit_with_auth(new_reading_club_note_path(@reading_club), @user)
    fill_in 'note[title]', with: 'New Note Title'
    assert_text 'This is Participating Template'
    click_button 'ノートを新規作成'
    assert_text 'ノートを作成しました'
    assert_current_path overview_reading_club_path(@reading_club)
    assert_text 'New Note Title'
  end

  test 'update note' do
    visit_with_auth(edit_note_path(@note1), @user)
    assert_text 'Content for note 1'

    fill_in 'note[title]', with: 'Updated Note Title'
    fill_in 'note[held_on]', with: Date.new(2024, 2, 1)

    execute_script("document.querySelector('.ProseMirror').innerHTML = ''")
    execute_script("document.querySelector('.ProseMirror').innerHTML = 'Updated content for note 1'")

    click_button 'ノートを更新'
    assert_text 'ノートを更新しました'
    visit current_path # 更新後も画面遷移しないので、リロードで確認
    assert_text 'Updated content for note 1'
  end

  test 'apply template to note' do
    visit_with_auth(edit_note_path(@note2), @user)
    assert_text 'Content for note 2'

    page.accept_confirm do
      click_button 'テンプレートを反映する'
    end

    visit current_path # 更新後も画面遷移しないので、リロードで確認
    assert_text 'This is Opening Template'
  end

  test 'update template' do
    visit_with_auth(edit_note_path(@note3), @user)
    assert_text 'Content for note 3'

    click_button 'テンプレートを変更する'
    assert_text 'This is Opening Template'
    find('.template-content-area').set('Updated Content')

    click_button '更新'
    assert_text 'テンプレートを更新しました'

    page.accept_confirm do
      click_button 'テンプレートを反映する'
    end

    assert_text 'Updated Content'
  end
end
