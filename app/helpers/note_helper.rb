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

  def summary_with_highlight(html, search_word, around_chars_count: 50)
    return if html.nil?

    plain_text = to_plain_text(html)

    match = to_plain_text(html).match(search_word)
    return if match.nil?

    summary = build_summary(match, around_chars_count, plain_text)

    to_highlight = Regexp.new(Regexp.escape(search_word), Regexp::IGNORECASE)

    summary_with_highlight = highlight(summary, to_highlight)

    "#{summary_with_highlight}..."
  end

  private

  def to_plain_text(html)
    strip_tags(html.gsub(%r{(</(?:p|li|h[1-6]|br|div|ul|ol)>)}, '\0 '))
  end

  def build_summary(match, around_chars_count, text)
    summary_start_index = [(match.begin(0) - around_chars_count), 0].max
    summary_end_index = [(match.end(0) + around_chars_count), text.length].min

    text[summary_start_index..summary_end_index]
  end

  def highlight(text, to_highlight)
    text.gsub(to_highlight) do |match|
      "<span class=\"font-bold bg-yellow-200\">#{match}</span>"
    end
  end
end
