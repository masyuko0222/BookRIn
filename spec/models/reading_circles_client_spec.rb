# spec/clients/reading_circles_client_spec.rb
require 'rails_helper'

RSpec.describe ReadingCirclesClient, type: :model do
  describe '.fetch' do
    it 'fetches all reading circles data from FBC API'do
      VCR.use_cassette('fetch_reading_circles') do
        result = ReadingCirclesClient.fetch
        json_fixture = Rails.root.join('spec/factories/reading_clubs_api.json')
        expected = JSON.parse(File.read(json_fixture))

        expect(result).to eq(expected)
      end
    end
  end

  describe '.save' do
    let!(:to_update_club) {
      ReadingClub.create!(
        id: 1000,
        title: 'アップデート予定の輪読会',
        finished: false,
        updated_at: Time.zone.parse('2000-01-01')
      )
    }
    let!(:to_destroy_club) {
      ReadingClub.create!(
        id: 3000,
        title: '削除予定の輪読会',
        finished: true,
        updated_at: Time.zone.parse('2000-01-01')
      )
    }
    let(:clubs_api) { [
      { 'id' => 1000, 'title' => 'アップデートした輪読会', 'finished' => true, 'updated_at' => Time.zone.parse('2024-01-01') },
      { 'id' => 2000, 'title' => '新規作成輪読会', 'finished' => false, 'updated_at' => Time.zone.parse('2025-01-01') },
    ] }

    context 'if created new club on FBC' do
      it 'creates new record on BookRIn' do
        expect { ReadingClub.find(2000) }.to raise_error(ActiveRecord::RecordNotFound)

        ReadingCirclesClient.save(clubs_api)

        created_club = ReadingClub.find(2000)
        expect(created_club.title).to eq('新規作成輪読会')
        expect(created_club.finished).to be(false)
        expect(created_club.updated_at).to eq(Time.zone.parse('2025-01-01'))
      end
    end

    context 'if existing on BookRIn and updated on FBC ' do

      it 'updates record on BookRIn' do
        expect(to_update_club.title).to eq('アップデート予定の輪読会')

        ReadingCirclesClient.save(clubs_api)
        updated_club = ReadingClub.find(to_update_club.id)

        expect(updated_club.title).to eq('アップデートした輪読会')
        expect(updated_club.finished).to be(true)
        expect(updated_club.updated_at).to eq(Time.zone.parse('2024-01-01'))
      end
    end

    context 'if existing on BookRIn and destroyed on FBC' do
      it 'destroys record on BookRIn' do
        expect(to_destroy_club.title).to eq('削除予定の輪読会')

        ReadingCirclesClient.save(clubs_api)

        expect { ReadingClub.find(to_destroy_club.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
