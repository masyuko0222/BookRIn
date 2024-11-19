# frozen_string_literal: true

require 'test_helper'

class ReadingClubsApiTest < ActiveSupport::TestCase
  setup do
    reading_clubs(:to_update_reading_club)
    reading_clubs(:to_destroy_reading_club)
    reading_clubs(:no_change_reading_club)

    data = {
      'reading_circles' => [
        {
          'id' => 1000,
          'title' => 'UpdatedClub',
          'finished' => true,
          'updated_at' => Time.zone.parse('2024-01-01')
        },
        {
          'id' => 3000,
          'title' => 'NoChangeClub',
          'finished' => false,
          'updated_at' => Time.zone.parse('2000-01-01')
        },
        {
          'id' => 4000,
          'title' => 'NewClub',
          'finished' => false,
          'updated_at' => Time.zone.parse('2030-01-01')
        }
      ]
    }

    @fetched_data = data['reading_circles']
  end

  test '.fetch' do
    VCR.use_cassette('fetch_reading_clubs') do
      result = ReadingClubsApi.fetch
      expect = JSON.parse(File.read('test/fixtures/reading_clubs_api.json'))

      assert_equal expect, result
    end
  end

  test '.update_clubs' do
    ReadingClubsApi.update_clubs(@fetched_data)

    updated_club = ReadingClub.find(1000)
    assert_equal 'UpdatedClub', updated_club.title
    assert updated_club.finished
    assert_equal Time.zone.parse('2024-01-01'), updated_club.updated_at
  end

  test '.create_clubs' do
    ReadingClubsApi.create_clubs(@fetched_data)

    new_club = ReadingClub.find(4000)
    assert_equal 'NewClub', new_club.title
    assert_not new_club.finished
    assert_equal Time.zone.parse('2030-01-01'), new_club.updated_at
  end

  test '.destroy_clubs' do
    ReadingClubsApi.destroy_clubs(@fetched_data)

    assert_raises(ActiveRecord::RecordNotFound) { ReadingClub.find(2000) }
  end
end
