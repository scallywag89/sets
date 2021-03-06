class PagesController < ApplicationController
  before_action :spotify_start, only: [:search]
  def home
  end

  def about
  end

  def dashboard
    @user = User.find(current_user.id)
    @stack = @user.stack
    @setlists = @user.setlists
  end

  def search
    unless params["search"].nil?
      @query = params["search"]["query"]
      if params["search"]["track"] == "0"
        search_albums
      else
        search_tracks
      end
    end
  end

  private

    def spotify_start
      @spotify = SpotifyService.new
      @spotify.authenticate
    end

    def search_albums
      @search = RSpotify::Album.search(@query)
      @albums = @search.map do |result|
        {
          id: result.id,
          artist: result.artists.first.name,
          title: result.name,
          year: result.release_date,
          cover_image_url: result.images.first["url"],
          tracks: result.tracks
        }
      end
    end

    def search_tracks
      @search = RSpotify::Track.search(@query)
      @tracks = @search.map do |result|
        {
          spotify_id: result.id,
          title: result.name,
          artist: result.artists.first.name,
          cover_image_url: result.album.images.first["url"]
        }
      end
    end
end
