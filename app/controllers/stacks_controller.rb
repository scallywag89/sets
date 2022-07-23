class StacksController < ApplicationController
  before_action :find_stack

  def show
    @albums = @stack.albums
    @stack_albums = @stack.stack_albums
  end

  def edit
  end

  def update
    @stack.update(params[:stack])
  end

  private

  def find_stack
    @stack = Stack.find_by_user_id(current_user.id)
  end
end
