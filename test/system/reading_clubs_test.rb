# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @user.participants.create!(reading_club: reading_clubs(:reading_club1))
  end

  test 'Click participant button' do
    visit_with_auth(reading_clubs_path, @user)
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('参加中のみ') }
    assert_text 'OpenClub 1'

    within(find('li', text: 'OpenClub 1')) do
      click_link '参加取消'
    end

    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('参加中のみ') }
    assert_text '参加中の輪読会はありません'

    fill_in '輪読会のタイトルで検索', with: 'OpenClub 1'
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('すべて') }

    assert_text 'OpenClub 1' # sleepの代わり

    within(find('li', text: /^OpenClub 1$/)) do
      assert_selector 'a', text: '参加'
    end
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
