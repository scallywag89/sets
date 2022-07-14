class PagesController < ApplicationController
  before_action :discogs_call, only: [:search]

  def home
    discogs_call = DiscogsCall.new
    discogs_call.callback
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
    end
  end

  private

  def discogs_call
    @discogs = Discogs::Wrapper.new("Sets", user_token: ENV["DISCOGS_USER_TOKEN"])
  end
end
