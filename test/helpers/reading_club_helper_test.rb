# frozen_string_literal: true

require 'test_helper'

class ReadingClubHelperTest < ActiveSupport::TestCase
  include ReadingClubHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  test '.participant_link as 参加リンク' do
    user = users(:user1)
    reading_club = reading_clubs(:reading_club1)
    link = participant_link(user, reading_club)

    assert_includes link, '参加'
    assert_includes link, reading_club_participants_path(reading_club)
    assert_includes link, 'data-turbo-method="post"'
  end

  test '.participant_link as 参加取消リンク' do
    user = users(:user1)
    reading_club = reading_clubs(:reading_club1)
    participant = Participant.create!(user:, reading_club:)
    link = participant_link(user, reading_club)

    assert_includes link, '参加取消'
    assert_includes link, participant_path(participant)
    assert_includes link, 'data-turbo-method="delete"'
  end
end
