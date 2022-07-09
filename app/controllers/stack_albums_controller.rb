class StackAlbumsController < ApplicationController
  before_action :find_stack_album, only: [:destroy]
  before_action :find_album, :find_stack, only: [:create]

  def create
    @stack_album = StackAlbum.new(stack: @stack, album: @album)
    @stack_album.save
  end

  def destroy
    @stack_album.destroy
  end

  private

  def find_stack
    @stack = Stack.where(id: params[:stack_id])
  end

  def find_album
    @album = Album.where(id: params[:album_id])
  end

  def find_stack_album
    @stack_album = StackAlbum.find(params[:id])
  end
end
