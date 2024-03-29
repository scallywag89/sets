class StackAlbumsController < ApplicationController
  before_action :find_stack_album, only: [:destroy]
  before_action :spotify_start, :find_album, :find_stack, only: [:create]

  def create()
    if !current_user.stack.album_ids.include?(@album.id)
      @stack_album = StackAlbum.new(stack_id: @stack.id, album_id: @album.id)
      @stack_album.save
      redirect_to request.referer, alert: "Album added to stack!"
    else
      redirect_to request.referer, alert: "You already have this album in your stack!"
    end
  end

  def destroy
    @stack_album.destroy
    redirect_to stack_path, notice: "Album deleted from stack!"
  end

  private

  def find_stack
    @stack = Stack.find_by_user_id(current_user.id)
  end

  def find_album
    if Album.find_by_spotify_id(params[:spotify_id])
      @album = Album.find_by_spotify_id(params[:spotify_id])
    else
      album = RSpotify::Album.find(params[:spotify_id])
      @album = Album.create(
        spotify_id: params[:spotify_id],
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
