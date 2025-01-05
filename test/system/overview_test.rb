# frozen_string_literal: true

require 'application_system_test_case'

class OverviewTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @reading_club = reading_clubs(:reading_club1)
  end

  test 'click participant link' do
    visit_with_auth(reading_club_overview_path(@reading_club), @user)

    assert_difference 'Participant.count', 1 do
      click_link '輪読会に参加する'
      assert_selector 'a', text: '参加取消'
    end

    assert_difference 'Participant.count', -1 do
      click_link '参加取消'
      assert_selector 'a', text: '輪読会に参加する'
    end
  end
end
