# frozen_string_literal: true

require 'test_helper'

class ReadingCirclesClientTest < ActiveSupport::TestCase
  test '.fetch' do
    VCR.use_cassette('fetch_reading_circles') do
      result = ReadingCirclesClient.fetch
      expect = JSON.parse(File.read('test/fixtures/reading_clubs_api.json'))

      assert_equal expect, result
    end
  end

  test '.save as update' do
    ReadingClub.create!(
      id: 1000,
      title: 'ToUpdateClub', finished: false,
      template: nil, read_me: nil,
      updated_at: Time.zone.parse('2000-01-01')
      )

    api_data = {
      'reading_circles' => [
        {
          'id' => 1000,
          'title' => 'UpdatedClub',
          'finished' => true,
          'updated_at' => Time.zone.parse('2024-01-01')
        }
      ]
    }

    latest_clubs = api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    updated_club = ReadingClub.find(1000)
    assert_equal 'UpdatedClub', updated_club.title
    assert updated_club.finished
    assert_equal Time.zone.parse('2024-01-01'), updated_club.updated_at
  end

  test '.save as create' do
    api_data = {
      'reading_circles' => [
        {
          'id' => 2000,
          'title' => 'NewClub',
          'finished' => false,
          'updated_at' => Time.zone.parse('2024-01-01')
        }
      ]
    }

    latest_clubs = api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    new_club = ReadingClub.find_by(title: 'NewClub')
    assert_not new_club.finished
    assert_equal Time.zone.parse('2024-01-01'), new_club.updated_at
  end

  test '.save as destroy' do
    ReadingClub.create!(
      id: 3000,
      title: 'ToDestroyClub', finished: true,
      template: nil, read_me: nil,
      updated_at: Time.zone.parse('2000-01-01')
      )

    api_data = {
      'reading_circles' => []
    }

    latest_clubs = api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    assert_raises(ActiveRecord::RecordNotFound) do
      ReadingClub.find(3000)
    end
  end
end
