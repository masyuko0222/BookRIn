# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
  end

  test 'Opening reading_clubs are ordered by updated_at desc.' do
    visit_with_auth(reading_clubs_path, @user)
    assert_selector 'h1', text: '輪読会一覧'

    club_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }
    expected_titles = (6..20).to_a.reverse.map { |i| "OpenClub #{i}" } # per_page 15

    assert_equal expected_titles, club_titles
  end

  test 'Participating opening reading_clubs are sorted at the top' do
    visit_with_auth(reading_clubs_path, @user)
    assert_selector 'h1', text: '輪読会一覧'

    within(find('li', text: 'OpenClub 6')) do
      click_link '参加'
    end
    assert_text '輪読会に参加しました！'

    within(find('li', text: 'OpenClub 9')) do
      click_link '参加'
      click_link '参加取消'
    end
    assert_text '輪読会の参加を取り消しました'

    visit reading_clubs_path
    assert_selector 'h1', text: '輪読会一覧'

    club_titles = page.all('ul li').map { |li| li.find('a', match: :first).text }
    expected_top_three_titles = ['OpenClub 6', 'OpenClub 20', 'OpenClub 19']

    assert_equal expected_top_three_titles, club_titles.first(3)
  end

  test 'Finished reading_clubs does not have participant links' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: ''
    choose '終了'
    click_button '検索'

    assert_no_selector 'a', text: '参加'
    assert_no_selector 'a', text: '参加取消'
  end
end
