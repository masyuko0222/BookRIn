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
    end
    assert_text '輪読会に参加しました！'

    within(find('li', text: 'OpenClub 20')) do
      click_link '参加取消'
    end
    assert_text '輪読会の参加を取り消しました'
  end

  test 'Search title' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: 'OpenClub 20'
    within('#participating_status') { choose('すべて') }
    within('#finished_status') { choose('すべて') }
    click_button '検索'
    assert_text 'OpenClub 20' # sleepの代わり

    hit_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }

    assert_equal hit_titles, ['OpenClub 20']
  end
end
