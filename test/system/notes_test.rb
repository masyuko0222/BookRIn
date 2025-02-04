# frozen_string_literal: true

require 'application_system_test_case'

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @note = notes(:note1)
  end

  test 'create new note' do
    reading_club = reading_clubs(:reading_club1)
    visit_with_auth(new_reading_club_note_path(reading_club_id: reading_club.id), @user)
    assert_current_path new_reading_club_note_path(reading_club_id: reading_club.id)

    assert_field 'note[held_on]', with: Time.zone.today
    editor_content = find('#note-editor')['data-content']
    assert_nil editor_content

    fill_in 'note[title]', with: 'New Note Title'
    # contentエリアはReactで実装されているので、execute_scriptで直接操作するようにする
    execute_script("document.querySelector('.ProseMirror').innerHTML = ''")
    execute_script("document.querySelector('.ProseMirror').innerHTML = 'New Content'")
    find('input[type="submit"]').click
    assert_text 'ノートを作成しました'

    assert_current_path overview_reading_club_path(id: reading_club.id)

    note = Note.last
    assert_text "#{note.held_on.strftime('%-m月%-d日')} #{note.title}"
  end

  # localでテストをする場合は、yjs-websocketを起動してください。
  # https://github.com/yjs/y-websocket
  # ws通信中はテストが終わってもcontentが更新されたままなので、テストごとにwebsocketを再起動してください
  test 'update note' do
    visit_with_auth(edit_note_path(@note), @user)
    assert_current_path edit_note_path(@note)

    assert_field 'note[title]', with: 'Note 1'
    assert_field 'note[held_on]', with: '2024-01-01'
    editor_content = find('#note-editor')['data-content']
    assert_text 'Content for note 1'

    # 更新
    fill_in 'note[title]', with: 'Updated Note Title'
    fill_in 'note[held_on]', with:  Date.new(2024, 2, 1)

    # contentエリアはReactで実装されているので、execute_scriptで直接操作するようにする
    execute_script("document.querySelector('.ProseMirror').innerHTML = ''")
    execute_script("document.querySelector('.ProseMirror').innerHTML = 'Updated content for note 1'")

    # click_buttonだと、なぜかCI環境でエラーを履くのでfind(xxx).clickで代用
    find('input[type="submit"]').click
    assert_text 'ノートを更新しました'

    assert_current_path edit_note_path(@note)
    assert_field 'note[title]', with: 'Updated Note Title'
    assert_field 'note[held_on]', with: '2024-02-01'
    assert_text 'Updated content for note 1'
  end
end
