# frozen_string_literal: true

class ReadingCirclesClient
  API_URL = 'https://bootcamp.fjord.jp/api/reading_circles.json'
  SESSION_URL = 'https://bootcamp.fjord.jp/api/session'
  class << self
    def fetch
      token = create_token(ENV['FBC_LOGIN_NAME'], ENV['FBC_PASSWORD'])

      uri = URI.parse(API_URL)
      req = Net::HTTP::Get.new(uri.path)
      req['Authorization'] = "Bearer #{token}"

      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
      JSON.parse(res.body)
    end

    def save(latest_clubs)
      ActiveRecord::Base.transaction do
        update_clubs!(latest_clubs)
        create_clubs!(latest_clubs)
        destroy_clubs!(latest_clubs)
      end
    end

    private

    def create_token(login_name, password)
      uri = URI.parse(SESSION_URL)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data({ login_name:, password: })

      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
      JSON.parse(res.body)['token']
    end

    def update_clubs!(latest_clubs)
      latest_clubs.each do |club|
        exist = ReadingClub.find_by(id: club['id'])

        exist.update!(club) if exist && exist.updated_at != club['updated_at']
      end
    end

    def create_clubs!(latest_clubs)
      latest_clubs.each do |club|
        exist = ReadingClub.find_by(id: club['id'])

        ReadingClub.create!(club) unless exist
      end
    end

    def destroy_clubs!(latest_clubs)
      fetched_ids = latest_clubs.map { |club| club['id'] }
      sample_titles = %w[
        参加中のサンプル輪読会1
        参加中のサンプル輪読会2
        参加中のサンプル輪読会3
      ]
      destroyed_clubs = ReadingClub.where.not(id: fetched_ids).where.not(title: sample_titles)
      destroyed_clubs.each(&:destroy!)
    end
  end
end
