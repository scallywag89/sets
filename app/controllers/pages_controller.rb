class PagesController < ApplicationController

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
  end
end
