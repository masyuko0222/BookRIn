# frozen_string_literal: true

require 'test_helper'

class NoteHelperTest < ActiveSupport::TestCase
  include NoteHelper

  test '.title_with_held_on(note)' do
    note = Note.new(
      held_on: Date.new(2024, 1, 1),
      title: '新年ノート'
    )

    expected_title = '1月1日 新年ノート'

    assert_equal expected_title, title_with_held_on(note)
  end
end
