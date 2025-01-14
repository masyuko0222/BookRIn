# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @user.participants.create!(reading_club: reading_clubs(:reading_club1))
  end


  test 'Search title' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: 'OpenClub 9'
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('すべて') }

    assert_text 'OpenClub 9' # sleepの代わり
    hit_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }

    assert_equal hit_titles, ['OpenClub 9']
  end
end
