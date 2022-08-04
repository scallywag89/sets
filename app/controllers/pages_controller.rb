class PagesController < ApplicationController
  before_action :spotify_start, only: [:search]
  before_action :set_setlists

  def home
  end

  def about
  end

  def dashboard
    @user = User.find(params[:id])
    @stack = @user.stack
    @setlists = @user.setlists
  end

  def search
    @set_track = SetTrack.new
    if params["search"].nil?
      nil_search
    else
      @query = params["search"]["query"]
      search_albums
      search_tracks
    end
  end

  private

    def set_setlists
      if current_user
        @setlists = Setlist.where(user_id: current_user.id)
      end
    end

    def spotify_start
      @spotify = SpotifyService.new
      @spotify.authenticate
    end

    def search_albums
      @search = RSpotify::Album.search(@query)
      # raise
      @albums = @search.map do |result|
        {
          id: result.id,
          artist: result.artists.first.name,
          title: result.name,
          year: result.release_date,
          cover_image_url: result.images.first["url"],
          tracks: result.tracks,
          type: result.type
        }
      end
    end

    def nil_search
      @search = RSpotify::Album.new_releases(limit: 20, offset: 0, country: nil)
      @search.delete_if { |album| album.album_type == "single" }
      @albums = @search.shuffle.map do |result|
        {
          id: result.id,
          artist: result.artists.first.name,
          title: result.name,
          year: result.release_date,
          cover_image_url: result.images.first["url"],
          tracks: result.tracks,
          type: result.type
        }
      end
      @tracks = @search.sample.tracks.map do |result|
        {
          spotify_id: result.id,
          name: result.name,
          artist: result.artists.first.name,
          cover_image_url: result.album.images.first["url"],
          type: result.type,
          duration: TimeConvert.milliseconds_to_minutes_and_seconds(result.duration_ms)
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
          cover_image_url: result.album.images.first["url"],
          type: result.type,
          duration: TimeConvert.milliseconds_to_minutes_and_seconds(result.duration_ms)
        }
      end
    end
end
