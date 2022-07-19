class StacksController < ApplicationController
  before_action :find_stack

  def show
  end

  def edit
  end

  def update
    @stack.update(params[:stack])
  end

  private

  def find_stack
    @stack = Stack.find(params[:id])
  end
end
