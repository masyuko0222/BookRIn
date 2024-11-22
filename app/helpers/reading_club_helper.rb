# frozen_string_literal: true

module ReadingClubHelper
  def card_color(reading_club)
    if reading_club.finished
      'bg-gray-300 hover:bg-gray-400'
    else
      'bg-blue-50 hover:bg-blue-100'
    end
  end

  def participant_link(reading_club)
    participant = reading_club.participants.find_by(user: current_user)

    if participant
      link_to '参加取消', participant_path(participant),
              data: { turbo_method: :delete },
              class: 'px-4 py-2 rounded-lg shadow-md bg-red-600 text-white transition-all hover:bg-red-700'
    else
      link_to '参加', reading_club_participants_path(reading_club),
              data: { turbo_method: :post },
              class: 'px-4 py-2 rounded-lg shadow-md bg-green-700 text-white transition-all hover:bg-red-700'
    end
  end
end
