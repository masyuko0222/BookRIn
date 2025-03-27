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

  def highlight_query_word(text, query_word, select_counts: 100)
    return if text.nil?
    plain_text = strip_tags(text.gsub(/<\/(p|li|h[1-6]|br|div|ul|ol)>/, '</\1> '))

    match = plain_text.match(query_word)
    return if match.nil?

    highlight_start_index = [(match.begin(0) - select_counts), 0].max
    highlight_end_index = [(match.end(0) + select_counts), plain_text.length].min

    highlight = plain_text[highlight_start_index..highlight_end_index]
    highlight + '...'
  end
end
