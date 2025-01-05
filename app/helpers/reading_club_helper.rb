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
    base_style = 'items-center px-3 py-1 cursor-pointer'

    if participant = user.participants.find_by(reading_club:)
      link_to '参加取消', participant_path(participant), data: { turbo_method: :delete },
      class: "#{base_style} text-gray-600 bg-gray-100 hover:bg-gray-200"
    else
      link_to '輪読会に参加する', reading_club_participants_path(reading_club), data: { turbo_method: :post },
      class: "#{base_style} text-white bg-main-color hover:bg-blue-700"
    end
  end
end
