# frozen_string_literal: true

module NoteHelper
  def title_with_held_on(note)
    "#{note.held_on.strftime('%-m月%-d日')} #{note.title}"
  end
end
