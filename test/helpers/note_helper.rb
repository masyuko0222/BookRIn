# frozen_string_literal: true

require 'test_helper'

class NoteHelperTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  include NoteHelper

  test '.title_with_held_on(note)' do
    note = Note.new(
      held_on: Date.new(2024, 1, 1),
      title: '新年ノート'
    )

    expected_title = '1月1日 新年ノート'

    assert_equal expected_title, title_with_held_on(note)
  end

  test '.submit_button_text' do
    new_note = Note.new
    assert_equal 'ノートを新規作成', submit_button_text(new_note)

    exist_note = notes(:note1)
    assert_equal 'ノートを更新', submit_button_text(exist_note)
  end

  test 'note_form_url' do
    new_note = Note.new(reading_club: reading_clubs(:reading_club1))
    assert_equal reading_club_notes_path(new_note.reading_club), note_form_url(new_note)

    exist_note = notes(:note1)
    assert_equal note_path(exist_note), note_form_url(exist_note)
  end
end
