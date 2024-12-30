# frozen_string_literal: true

module ReadingClubHelper
  def to_html(md_text)
    # Redcarpet gemのUsageそのままを書いているだけなのでテストはしない
    return unless md_text

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(md_text)
  end
end
