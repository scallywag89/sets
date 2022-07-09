class PagesController < ApplicationController

  def home
    discogs_call = DiscogsCall.new
    discogs_call.callback
  end

  def about
  end

  def dashboard
  end

  def search
  end
end
