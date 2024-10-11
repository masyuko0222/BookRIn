# frozen_string_literal: true

require 'test_helper'

class ReadingClubTest < ActiveSupport::TestCase
  test '#opening_clubs_participated_by(user)' do
    user = users(:user1)

    r1 = reading_clubs(:reading_club1)
    r3 = reading_clubs(:reading_club3)
    r20 = reading_clubs(:reading_club20)

    [r1, r3, r20].each do |r|
      user.participants.create!(reading_club: r)
    end

    clubs = ReadingClub.opening_clubs_participated_by(user)

    assert_equal 3, clubs.count
    assert_equal [r20, r3, r1], clubs.first(3) # 後から参加したものが先頭にくる
  end
end
