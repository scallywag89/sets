class PagesController < ApplicationController
  before_action :spotify_start, only: [:search]
  before_action :set_setlists

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
    @setlist = Setlist.first
    @set_track = SetTrack.new
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

    def set_setlists
      @setlists = Setlist.where(user_id: current_user.id)
    end

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
          name: result.name,
          artist: result.artists.first.name,
          cover_image_url: result.album.images.first["url"]
        }
      end
    end
end
