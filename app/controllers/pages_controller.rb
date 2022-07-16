class PagesController < ApplicationController
  def home
  end

  def about
  end

  def dashboard
    @user = User.where(id: params[:user_id])
  end

  def search
    @spotify = SpotifyService.new
    @spotify.authenticate
    unless params["search"].nil?
      @query = params["search"]["query"]
      if params["search"]["track"] == "1"
        @search = RSpotify::Album.search(@query)
        @albums = @search.map do |result|
          {
            artist: result.artists.first.name,
            title: result.name,
            year: result.release_date,
            cover_image_url: result.images.first["url"]
          }
        end
      else
        @search = RSpotify::Track.search(@query)
        @tracks = @search.map do |result|
          {
            name: result.name,
            album_id: result.album
          }
        end
      end
    end
  end

end
