# frozen_string_literal: true

require 'test_helper'

class ReadingClubTest < ActiveSupport::TestCase
  setup do
    @user = users(:user1)
    participating_clubs = {
      5.days.ago => reading_clubs(:reading_club5),
      12.days.ago => reading_clubs(:reading_club12),
      20.days.ago => reading_clubs(:reading_club20),
      5.days.ago => reading_clubs(:finished_reading_club5),
      12.days.ago => reading_clubs(:finished_reading_club12),
      20.days.ago => reading_clubs(:finished_reading_club20)
    }

    create_participations(@user, participating_clubs)
  end

  test '.sort_by_participations sort finished clubs by recent update' do
    search_query = ReadingClub.ransack(finished_eq: 'true', title_cont: '2')
    result = search_query.result.includes(:participants)

    expected = [
      reading_clubs(:finished_reading_club2),
      reading_clubs(:finished_reading_club12),
      reading_clubs(:finished_reading_club20)
    ]

    actual =
      ReadingClub.sort_by_participations(
        result,
        @user,
        is_requested_open: false
      )

    assert_equal expected, actual
  end

  test '.sort_by_participations sort opening clubs by user participants' do
    search_query = ReadingClub.ransack(finished_eq: 'false', title_cont: '2')
    result = search_query.result.includes(:participants)

    expected = [
      reading_clubs(:reading_club12),
      reading_clubs(:reading_club20),
      reading_clubs(:reading_club2)
    ]

    actual =
      ReadingClub.sort_by_participations(
        result,
        @user,
        is_requested_open: true
      )

    assert_equal expected, actual
  end

  private

  def create_participations(user, clubs)
    clubs.each do |created_at, club|
      user.participants.create!(reading_club: club, created_at:)
    end
  end
end
