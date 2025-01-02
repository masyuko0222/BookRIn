# frozen_string_literal: true

module ReadingClubHelper
  def to_html(md_text)
    # Redcarpet gemのUsageそのままを書いているだけなのでテストはしない
    return unless md_text

    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(md_text)
  end

  def participant_link(user, reading_club)
    if participant = user.participants.find_by(reading_club:)
      link_to '参加取消', participant_path(participant), data: { turbo_method: :delete }
    else
      link_to '参加', reading_club_participants_path(reading_club), data: { turbo_method: :post }
    end
  end
end
