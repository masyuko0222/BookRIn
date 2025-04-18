# frozen_string_literal: true

require 'test_helper'

class ReadingCirclesClientTest < ActiveSupport::TestCase
  setup do
    @latest_api_data = {
      'reading_circles' => [
        {
          'id' => 1000,
          'title' => 'アップデートされた輪読会',
          'finished' => false,
          'updated_at' => Time.zone.parse('2024-01-01')
        },
        {
          'id' => 2000,
          'title' => '新規作成輪読会',
          'finished' => false,
          'updated_at' => Time.zone.parse('2025-01-01')
        }
        # id 3000の輪読会は削除
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

  test '.save as update' do
    ReadingClub.create!(
      id: 1000,
      title: 'アップデート予定の輪読会',
      finished: true,
      updated_at: Time.zone.parse('2000-01-01'),
      template: 'update template',
      read_me: 'update read me'
    )

    original_club = ReadingClub.find(1000)
    assert_equal 'アップデート予定の輪読会', original_club.title
    assert original_club.finished
    assert_equal Time.zone.parse('2000-01-01'), original_club.updated_at

    # 最新の輪読会を取得して保存
    latest_clubs = @latest_api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    updated_club = ReadingClub.find(1000)
    assert_equal 'アップデートされた輪読会', updated_club.title
    assert_not updated_club.finished
    assert_equal Time.zone.parse('2024-01-01'), updated_club.updated_at
  end

  test '.save as create' do
    assert_raises(ActiveRecord::RecordNotFound) do
      ReadingClub.find(2000)
    end

    # 最新の輪読会を取得して保存
    latest_clubs = @latest_api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    new_club = ReadingClub.find(2000)
    assert_equal '新規作成輪読会', new_club.title
    assert_not new_club.finished
    assert_equal Time.zone.parse('2025-01-01'), new_club.updated_at
  end

  test '.save as destroy' do
    ReadingClub.create!(
      id: 3000,
      title: '削除予定の輪読会',
      finished: true,
      updated_at: Time.zone.parse('2000-01-01'),
      template: 'destroy template',
      read_me: 'destroy read me'
    )

    assert ReadingClub.find(3000)

    # 最新の輪読会を取得して保存
    latest_clubs = @latest_api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)

    assert_raises(ActiveRecord::RecordNotFound) do
      ReadingClub.find(3000)
    end
  end

  test '.save as update does not overwrite tempalte and read_me' do
    ReadingClub.create!(
      id: 4000,
      title: 'テンプレートとREAD MEがある輪読会',
      finished: true,
      updated_at: Time.zone.parse('2000-01-01'),
      template: 'This is template.',
      read_me: 'This is READ ME'
    )

    latest_clubs = [{
      'id' => 4000,
      'title' => 'アップデートされた輪読会',
      'finished' => false,
      'updated_at' => Time.zone.parse('2024-01-01')
      # templateとread_meはAPIデータには存在しない
    }]

    ReadingCirclesClient.save(latest_clubs)

    updated_club = ReadingClub.find(4000)
    assert_equal 'アップデートされた輪読会', updated_club.title
    assert_equal 'This is template.', updated_club.template
    assert_equal 'This is READ ME', updated_club.read_me
  end
end
