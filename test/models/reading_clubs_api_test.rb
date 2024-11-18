# frozen_string_literal: true

require 'test_helper'

class ReadingClubsApiTest < ActiveSupport::TestCase
  test '.fetch' do
    VCR.use_cassette('fetch_reading_clubs') do
      result = ReadingClubsApi.fetch
      expect = JSON.parse(File.read('test/fixtures/reading_clubs_api.json'))

      assert_equal expect, result
    end
  end
end
