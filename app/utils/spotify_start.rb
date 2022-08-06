class SpotifyStart

  def spotify_start
    @spotify = SpotifyService.new
    @spotify.authenticate
  end

end
