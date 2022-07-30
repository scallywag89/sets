class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [ :toggle_favorite, :index ]

  def show; end

  def index
    users_favoritors_hash = User.all.each_with_object({}) do |user, hash|
      hash[user] = user.favoritors.count
    end
    @users = users_favoritors_hash.sort_by { |y| y.last }.reverse.map { |user| user.first }
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
