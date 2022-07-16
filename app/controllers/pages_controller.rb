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
      @options = params["search"]["options"]
      @search = RSpotify::Album.search(@query)

      if @search
        @albums = @search.map do |result|
          {
            artist: result.artists.first.name,
            title: result.name,
            year: result.release_date,
            cover_image_url: result.images.first["url"]
          }
        end
      end
    end
  end
end
