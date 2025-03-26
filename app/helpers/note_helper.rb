# frozen_string_literal: true

module NoteHelper
  def title_with_held_on(note)
    "#{note.held_on.strftime('%-m月%-d日')} #{note.title}"
  end

  def submit_button_text(note)
    note.new_record? ? '作成' : 'ノートを更新'
  end

  def note_form_url(note)
    # ControllerのNote.newでカラムの初期値を入れている
    # そのためform_withが自動でurlを判別できないので、helperでロジックを定義しておく
    note.new_record? ? reading_club_notes_path(note.reading_club) : note_path(note)
  end
end
