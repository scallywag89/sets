class PagesController < ApplicationController
  before_action :discogs_call, only: [:search]

  def home
    discogs_service = DiscogsService.new
    discogs_service.callback
  end

  def about
  end

  def dashboard
    @user = User.where(id: params[:user_id])
  end

  def search
    unless params["search"].nil?
      @query = params["search"]["query"]
      @search = @discogs.search(@query)
      if search
        @albums = @search.results.map do |result|
          if result.type == "master" || result.type == "release"
            {
              artist: result.title.split(" - ")[0],
              title: result.title.split(" - ")[1],
              year: result.year,
              cover_image_url: result.cover_image
            }
          end
        end.compact!
      end
    end
  end

  private

  def discogs_call
    @discogs = Discogs::Wrapper.new("Sets", user_token: ENV["DISCOGS_USER_TOKEN"])
  end
end
