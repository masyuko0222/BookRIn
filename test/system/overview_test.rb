# frozen_string_literal: true

require 'application_system_test_case'

class OverviewTest < ApplicationSystemTestCase
  setup do
    @user = users(:alice)
  end

  test 'Participant reading club' do
    not_participanting_club = reading_clubs(:opening_club)

    visit_with_auth(reading_club_overview_path(not_participanting_club), @user)

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

    visit_with_auth(reading_club_overview_path(participating_club), @user)

    assert_difference 'Participant.count', -1 do
      click_link '参加取消'
      assert_selector 'a', text: '輪読会に参加する'
    end

    visit_with_auth(reading_clubs_path, @user)
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('参加中のみ') }

    assert_text '参加中の輪読会はありません'
  end

  test 'destroy note' do
    reading_club = reading_clubs(:opening_club)
    note = notes(:existing_note)

    visit_with_auth(reading_club_overview_path(reading_club), @user)
    assert_current_path reading_club_overview_path(reading_club)

    within("turbo-frame##{dom_id(note)}") do
      assert_selector 'a', text: '削除', visible: :hidden
      find('#hoverable-note').hover

      assert_selector 'a', text: '削除', visible: true

      accept_confirm do
        click_link '削除'
      end
    end

    assert_no_selector "turbo-frame##{dom_id(note)}"
    assert_no_text 'テストノート'
  end
end
