class StackAlbumsController < ApplicationController
  before_action :find_stack_album, only: [:destroy]
  before_action :find_album, :find_stack, only: [:create]

  def create()
    @stack_album = StackAlbum.new(stack_id: @stack.id, album_id: @album.id)
    @stack_album.save
  end

  def destroy
    @stack_album.destroy
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
        id: album.id,
        artist: album.artists.first.name,
        title: album.name,
        year: album.release_date.slice(0..3),
        cover_image_url: album.images.first["url"]
      )
    end
  end

  def find_stack_album
    @stack_album = StackAlbum.find(params[:id])
  end
end
