# frozen_string_literal: true

require 'application_system_test_case'

class NotesTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @reading_club = reading_clubs(:reading_club_with_read_me)
    @note = notes(:note1)
  end

  test 'delete note' do
    visit_with_auth(reading_club_overview_path(@reading_club), @user)
    assert_current_path reading_club_overview_path(@reading_club)

    within("[data-test-id='reading-club-notes']") do
      find('li', text: @note.title.to_s, match: :first).hover

      accept_alert('ノートを削除しますか？') do
        click_on '×'
      end
    end

    # Turboを利用しているからか単なる`assert_no_text`だと失敗してしまう(要調査)
    # そのため、DOMの要素を直接検証するようにした
    assert_selector "turbo-frame[id='note_#{notes(:note2).id}']"
    assert_no_selector "turbo-frame[id='note_#{@note.id}']"

    assert_text 'ノートを削除しました'
  end
end
