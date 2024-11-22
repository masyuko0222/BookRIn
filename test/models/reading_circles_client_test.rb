# frozen_string_literal: true

require 'test_helper'

class ReadingCirclesClientTest < ActiveSupport::TestCase
  setup do
    reading_clubs(:to_update_reading_club)
    reading_clubs(:to_destroy_reading_club)
    reading_clubs(:no_change_reading_club)

    @data = {
      'reading_circles' => [
        { 'id' => 1000, 'title' => 'UpdatedClub', 'finished' => true, 'updated_at' => Time.zone.parse('2024-01-01') },
        { 'id' => 3000, 'title' => 'NoChangeClub', 'finished' => false, 'updated_at' => Time.zone.parse('2000-01-01') },
        { 'id' => 4000, 'title' => 'NewClub', 'finished' => false, 'updated_at' => Time.zone.parse('2030-01-01') }
      ]
    }
  end

  test '.fetch' do
    VCR.use_cassette('fetch_reading_circles') do
      result = ReadingCirclesClient.fetch
      expect = JSON.parse(File.read('test/fixtures/reading_clubs_api.json'))

      assert_equal expect, result
    end
  end

  test '.save' do
    to_update_club = ReadingClub.create!(
      title: 'ToUpdateClub', finished: false,
      template: nil, read_me: nil,
      updated_at: Time.zone.parse('2000-01-01')
      )

    to_destroy_club = ReadingClub.create!(
      title: 'ToDestroyClub', finished: true,
      template: nil, read_me: nil,
      updated_at: Time.zone.parse('2000-01-01')
      )

    no_change_club = ReadingClub.create!(
      title: 'NoChangeClub', finished: false,
      template: nil, read_me: nil,
      updated_at: Time.zone.parse('2000-01-01')
      )

    latest_clubs = @data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    updated_club = ReadingClub.find_by(title: 'UpdatedClub')
    assert updated_club.finished
    assert_equal Time.zone.parse('2024-01-01'), updated_club.updated_at

    assert_nil ReadingClub.find_by(title: 'ToDestroyClub')

    new_club = ReadingClub.find_by(title: 'NewClub')
    assert_not new_club.finished
    assert_equal Time.zone.parse('2030-01-01'), new_club.updated_at
  end
end
