# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
    @user.participants.create!(reading_club: reading_clubs(:reading_club1))
  end

  test 'Click participant button' do
    visit_with_auth(reading_clubs_path, @user)
    assert_current_path reading_clubs_path

    within(find('li', text: 'OpenClub 20')) do
      click_link '参加'
      assert_selector 'a', text: '参加取消'
    end

    within(find('li', text: 'OpenClub 20')) do
      click_link '参加取消'
      assert_selector 'a', text: '参加'
    end
  end

  test 'Search title' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: 'OpenClub 9'
    within("[data-test-id='participating-status']") { choose('開催中') }
    within("[data-test-id='finished-status']") { choose('すべて') }

    hit_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }

    assert_equal hit_titles, ['OpenClub 9']
  end
end
