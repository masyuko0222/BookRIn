# frozen_string_literal: true

class ReadingClubsApi
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

    def update_clubs(fetched_data)
      fetched_data.each do |data|
        attributes = data.slice('id', 'title', 'finished', 'updated_at')
        exist = ReadingClub.find_by(id: data['id'])

        exist.update!(attributes) if exist && exist.updated_at != data['updated_at']
      end
    end

    def create_clubs(fetched_data)
      fetched_data.each do |data|
        attributes = data.slice('id', 'title', 'finished', 'updated_at')
        exist = ReadingClub.find_by(id: data['id'])

        ReadingClub.create!(attributes) unless exist
      end
    end

    def destroy_clubs(fetched_data)
      fetched_ids = fetched_data.map { |data| data['id'] }
      destroyed_clubs = ReadingClub.where.not(id: fetched_ids)
      destroyed_clubs.destroy_all
    end

    private

    def create_token(login_name, password)
      uri = URI.parse(SESSION_URL)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data({ login_name:, password: })

      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
      JSON.parse(res.body)['token']
    end
  end
end
