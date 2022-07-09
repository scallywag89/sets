class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]
  def index
    @albums = Album.all
  end

  def show
  end

  def create
    @album = Album.new(album_params)
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title)
  end
end
