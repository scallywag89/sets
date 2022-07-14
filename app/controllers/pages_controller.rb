class PagesController < ApplicationController

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
  end
end
