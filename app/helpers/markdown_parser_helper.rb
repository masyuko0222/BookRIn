# frozen_string_literal: true

module MarkdownParserHelper
  def to_html(md_text)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    html_text = markdown.render(md_text)

    sanitize_html(html_text)
  end

  private

  def sanitize_html(html_text)
    tags = %w[h1 h2 h3 h4 h5 h6 p strong em a ul ol li code pre]
    attributes = %w[href]
    sanitize(html_text, tags:, attributes:)
  end
end
