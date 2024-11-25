namespace :fetch do
  desc 'Fetch latest reading circles(this app calls reading clubs) from FBC API.'
  task reading_clubs: :environment do
    api_data = ReadingCirclesClient.fetch
    latest_clubs = api_data['reading_circles']
    ReadingCirclesClient.save(latest_clubs)
  end
end
