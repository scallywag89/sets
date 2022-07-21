class StackAlbumsController < ApplicationController
  before_action :find_stack_album, only: [:destroy]
  before_action :find_album, :find_stack, only: [:create]

  def create()
    @stack_album = StackAlbum.new(stack_id: @stack.id, album_id: @album.id)
    @stack_album.save
    redirect_to albums_path
  end

  def destroy
    @stack_album.destroy
  end

  private

  def find_stack
    @stack = Stack.find_by_user_id(current_user.id)
  end

  def find_album
    @album = Album.find(params[:album_id])
  end

  def find_stack_album
    @stack_album = StackAlbum.find(params[:id])
  end
end
