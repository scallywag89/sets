class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [ :toggle_favorite, :index ]

  def show; end

  def index
    @users = User.all.sort_by { |user| user.favoritors.count }.reverse
  end

  def following
    @favorite_users = current_user.favorited_by_type('User')
  end

  def toggle_favorite
    @user = User.find_by(id: params[:id])
    current_user.favorited?(@user) ? current_user.unfavorite(@user) : current_user.favorite(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
