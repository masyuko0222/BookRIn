# frozen_string_literal: true

require 'application_system_test_case'

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @note = notes(:note1)
  end

  test 'update note' do
    visit_with_auth(edit_note_path(@note), @user)
    assert_current_path edit_note_path(@note)

    assert_field 'note[title]', with: 'Note 1'
    assert_field 'note[held_on]', with: '2024-01-01'
    editor_content = find('#note-editor')['data-content']
    assert_equal 'Content for note 1', editor_content

    # 更新
    fill_in 'note[title]', with: 'Updated Note Title'
    fill_in 'note[held_on]', with:  Date.new(2024, 2, 1)

    # contentエリアはReactで実装されているので、execute_scriptで直接操作するようにする
    execute_script("document.querySelector('.ProseMirror').innerHTML = ''")
    execute_script("document.querySelector('.ProseMirror').innerHTML = 'Updated content for note 1'")

    find('input[type="submit"]').click # click_buttonだとなぜかCIでだけエラーが。。。
    assert_text 'ノートを更新しました'

    assert_current_path edit_note_path(@note)
    assert_field 'note[title]', with: 'Updated Note Title'
    assert_field 'note[held_on]', with: '2024-02-01'
    assert_text 'Updated content for note 1'
  end
end
