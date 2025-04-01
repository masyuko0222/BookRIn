# frozen_string_literal: true

require 'application_system_test_case'

# NotesTestはyjs-websocketを起動しながらテストをしてください
# `HOST=localhost PORT=5678 npx y-websocket` https://github.com/yjs/y-websocket
# Websocket起動中は最後に編集された内容を保持してしまうので、テスト毎に起動しなおしてください

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:alice)
    @reading_club = reading_clubs(:participating_club)

    # Websocket通信中は、各テストで利用するノートを変える
    # Websocket起動中は最後に編集された内容を保持してしまうため
    @existing_note = notes(:existing_note)
    @note_to_apply_template = notes(:note_to_apply_template)
    @note_to_update_template = notes(:note_to_update_template)
  end

  test 'create new note' do
    visit_with_auth(new_reading_club_note_path(@reading_club), @user)
    fill_in 'note[title]', with: 'New Note Title'
    assert_text 'This is Participating Template'
    click_button '作成'
    assert_text 'ノートを作成しました'
    assert_current_path reading_club_overview_path(@reading_club)
    assert_text 'New Note Title'
  end

  test 'update note' do
    visit_with_auth(edit_note_path(@existing_note), @user)
    assert_text 'Content for existing note'

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
    visit_with_auth(edit_note_path(@note_to_apply_template), @user)
    assert_text 'Content for note to apply template'

    page.accept_confirm do
      click_button 'テンプレートをノートに反映する'
    end

    visit current_path # 更新後も画面遷移しないので、リロードで確認
    assert_text 'This is Opening Template'
  end

  test 'update template' do
    visit_with_auth(edit_note_path(@note_to_update_template), @user)
    assert_text 'Content for note to update template'

    click_button 'テンプレートを編集する'
    assert_text 'This is Opening Template'
    find('.template-content-area').set('Updated Content')

    click_button '更新'
    assert_text 'テンプレートを更新しました'

    page.accept_confirm do
      click_button 'テンプレートをノートに反映する'
    end

    assert_text 'Updated Content'
  end
end
