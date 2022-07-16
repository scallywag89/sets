# require 'dotenv/load'

class SpotifyService
  def authenticate
    RSpotify::authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
  end
end
