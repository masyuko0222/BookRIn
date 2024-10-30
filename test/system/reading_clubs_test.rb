# frozen_string_literal: true

require 'application_system_test_case'

class ReadingClubsTest < ApplicationSystemTestCase
  setup do
    @user = users(:user1)
  end

  test 'Opening reading_clubs ordered by updated_at desc are shown initially.' do
    @user.participating_reading_clubs.destroy_all

    visit_with_auth(reading_clubs_path, @user)
    assert_selector 'h1', text: '輪読会一覧'

    titles = page.all('ul li').map { |li| li.find('a', match: :first).text }

    per_page = ReadingClub.default_per_page # １ページに15件表示される設定

    start_number = 20
    end_number = start_number - per_page + 1
    # OpenClub 20..5の順で並ぶ
    expected_titles = (end_number..start_number).to_a.reverse.map { |i| "OpenClub #{i}" }

    assert_equal expected_titles, titles
  end

  test 'Opening reading_clubs that the current user is participating in are sorted at the top' do
    participating_reading_clubs =
      [
        reading_clubs(:reading_club1),
        reading_clubs(:reading_club5),
        reading_clubs(:reading_club20)
      ]

    participating_reading_clubs.each do |reading_club|
      @user.participants.create!(reading_club_id: reading_club.id)
    end

    visit_with_auth(reading_clubs_path, @user)

    titles = page.all('ul li').map { |li| li.find('a', match: :first).text }
    # 最近参加した輪読会から順に出力される
    expected_top_titles = ['OpenClub 20', 'OpenClub 5', 'OpenClub 1']

    assert_equal expected_top_titles, titles.first(3)
  end

  test 'finished reading_clubs does not have participant links' do
    visit_with_auth(reading_clubs_path, @user)
    fill_in '輪読会のタイトルで検索', with: ''
    choose '終了'
    click_button '検索'

    assert_no_selector 'a', text: '参加'
    assert_no_selector 'a', text: '参加取消'
  end
end
