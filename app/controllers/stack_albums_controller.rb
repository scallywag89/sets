class StackAlbumsController < ApplicationController
  before_action :find_stack_album, only: [:destroy]
  before_action :spotify_start, :find_album, :find_stack, only: [:create]

  def create()
    @stack_album = StackAlbum.new(stack_id: @stack.id, album_id: @album.id)
    @stack_album.save
  end

  def destroy
    @stack_album.destroy
    redirect_to stack_path
  end

  private

  def find_stack
    @stack = Stack.find_by_user_id(current_user.id)
  end

  def find_album
    if Album.find_by_id(params[:album_id])
      @album = Album.find(params[:album_id])
    else
      album = RSpotify::Album.find(params[:album_id])
      @album = Album.create(
        spotify_id: params[:album_id],
        artist: album.artists.first.name,
        title: album.name,
        year: album.release_date,
        cover_image_url: album.images.first["url"]
      )
    end
  end

  def find_stack_album
    @stack = Stack.where(user: current_user)
    @stack_album = StackAlbum.find(params[:id])
  end

  def spotify_start
    @spotify = SpotifyService.new
    @spotify.authenticate
  end
end
