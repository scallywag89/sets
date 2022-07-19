class PagesController < ApplicationController
  before_action :spotify_start, only: [:search]
  def home
  end

  def about
  end

  def dashboard
    @user = User.find(current_user.id)
    @stack = @user.stack
    @sets = @user.setlists
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
      unless @search.nil?
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
    end

    def search_tracks
      unless @search.nil?
        @search = RSpotify::Track.search(@query)
        @tracks = @search.map do |result|
          {
            title: result.name,
            artist: result.artists.first.name,
            cover_image_url: result.album.images.first["url"]
          }
        end
      end
    end
end
