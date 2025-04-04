# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:alice)
    @user.participants.create!(reading_club: reading_clubs(:opening_club))
  end

  test 'Search title' do
    visit_with_auth(reading_clubs_path, @user)
    assert_text 'ParticipatingClub'

    fill_in 'q_title_cont', with: 'OpeningClub'
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('すべて') }

    assert_text 'OpeningClub'
    assert_no_text 'PariticipatingClub'
  end
end
