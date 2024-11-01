# frozen_string_literal: true

require 'test_helper'

class ReadingClubTest < ActiveSupport::TestCase
  setup do
    @user = users(:user1)

    @r2 = reading_clubs(:reading_club1)
    @r5 = reading_clubs(:reading_club5)
    @r12 = reading_clubs(:reading_club10)
    @r20 = reading_clubs(:reading_club20)

    @user.participants.create!(reading_club: @r12, created_at: 1.day.ago)
    @user.participants.create!(reading_club: @r5, created_at: 2.days.ago)
    @user.participants.create!(reading_club: @r2, created_at: 3.days.ago)
  end
  test '.sort_participating_first' do
    # '2'の文字列にヒットするもの
    hit_clubs = [@r2, @r12, @r20]

    expected_sorted_clubs = [@r12, @r2, @r20]

    assert_equal expected_sorted_clubs, ReadingClub.sort_participating_first(hit_clubs, @user)
  end
end
