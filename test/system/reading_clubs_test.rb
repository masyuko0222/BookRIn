# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @user.participants.create!(reading_club: reading_clubs(:opening_club))
  end

  test 'Search title' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: 'OpeningClub'
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('すべて') }

    assert_text 'OpeningClub' # sleepの代わり
    hit_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }
    take_screenshot

    assert_equal ['OpeningClub'], hit_titles
  end
end
