# frozen_string_literal: true

require 'test_helper'

class NoteHelperTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  include NoteHelper
  include ActionView::Helpers::SanitizeHelper

  setup do
    @note = Note.new(
      held_on: Date.new(2024, 1, 1),
      title: '新年ノート'
    )
  end

  test '.title_with_held_on(note)' do
    expected_title = '1月1日 新年ノート'

    assert_equal expected_title, title_with_held_on(@note)
  end

  test '.submit_button_text' do
    new_note = Note.new
    assert_equal '作成', submit_button_text(new_note)

    exist_note = notes(:note1)
    assert_equal 'ノートを更新', submit_button_text(exist_note)
  end

  test 'note_form_url' do
    new_note = Note.new(reading_club: reading_clubs(:opening_club))
    assert_equal reading_club_notes_path(new_note.reading_club), note_form_url(new_note)

    exist_note = notes(:note1)
    assert_equal note_path(exist_note), note_form_url(exist_note)
  end

  test 'summary_with_highlight' do
    @note.content = '<h1>こんにちは!</h1><p>こんばんは!</p>'
    search_word = 'こん'
    expected =
      '<span class="font-bold bg-yellow-200">こん</span>にちは! <span class="font-bold bg-yellow-200">こん</span>ばんは! ...'

    assert_equal expected, summary_with_highlight(@note.content, search_word)
  end
end
