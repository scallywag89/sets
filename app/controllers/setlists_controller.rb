class SetlistsController < ApplicationController
  before_action :find_setlist, only: [:show, :edit, :update, :destroy]

  def index
    @setlists = Setlist.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @setlist = Setlist.new
  end

  def create
    @setlist = Setlist.new(setlist_params)
    @setlist.user = current_user
    if @setlist.save
      redirect_to setlist_path(@setlist)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @setlist.update(params[:setlist])
  end

  def destroy
    @setlist.destroy
    redirect_to root
  end

  private

  def setlist_params
    params.require(:setlist).permit(:name)
  end

  def find_setlist
    @setlist = Setlist.find(params[:id])
  end

end
