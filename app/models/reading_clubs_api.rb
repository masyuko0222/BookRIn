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
