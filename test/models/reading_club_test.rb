# frozen_string_literal: true

require 'test_helper'

class ReadingClubTest < ActiveSupport::TestCase
  setup do
    @user = users(:user1)

    [
      reading_clubs(:reading_club1),
      reading_clubs(:reading_club3),
      reading_clubs(:reading_club20)
    ].each do |club|
      @user.participants.create!(reading_club: club)
    end
  end

  test '#opening_clubs_participated_by(user)' do
    expected_clubs = [
      reading_clubs(:reading_club20),
      reading_clubs(:reading_club3),
      reading_clubs(:reading_club1)
    ]

    # 参加日時降順
    assert_equal expected_clubs, ReadingClub.opening_clubs_participated_by(@user)
  end
end
