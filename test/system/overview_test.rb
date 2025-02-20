# frozen_string_literal: true

require 'application_system_test_case'

class OverviewTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
  end

  test 'Participant reading club' do
    not_participanting_club = reading_clubs(:opening_club)

    visit_with_auth(overview_reading_club_path(not_participanting_club), @user)

    assert_difference 'Participant.count', 1 do
      click_link '輪読会に参加する'
      assert_selector 'a', text: '参加取消'
    end

    visit_with_auth(reading_clubs_path, @user)

    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('参加中のみ') }
    assert_text 'OpeningClub'
  end

  test 'Cancell participating reading club' do
    participating_club = reading_clubs(:participating_club)

    visit_with_auth(overview_reading_club_path(participating_club), @user)

    assert_difference 'Participant.count', -1 do
      click_link '参加取消'
      assert_selector 'a', text: '輪読会に参加する'
    end

    visit_with_auth(reading_clubs_path, @user)
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('参加中のみ') }

    assert_text '参加中の輪読会はありません'
  end
end
