class SetlistsController < ApplicationController
  before_action :find_setlist, only: [:show, :edit, :update, :destroy]
  before_action :set_user_stack_tracks, only: [:show]

  def index
    @setlists = Setlist.where(user_id: current_user.id)
  end

  def show
    @stack_spot_ids = @tracks.pluck(:spotify_id)
    @setlist_spot_ids = @setlist.tracks.pluck(:spotify_id)
    @albums_in_setlist = @setlist.tracks.map{ |track| track.album }.uniq
    @albums_in_stack = current_user.stack.albums.uniq
    @albums_in_setlist_and_stack = @albums_in_setlist & @albums_in_stack
    @albums_in_setlist_and_not_stack = @albums_in_setlist - @albums_in_stack
  end

  def new
    @setlist = Setlist.new
  end

  def create
    @setlist = Setlist.new(setlist_params)
    @setlist.user = current_user
    # raise
    if params[:setlist][:track] != ""
      find_track
      SetTrack.create(setlist: @setlist, track: @track)
    end
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
    params.require(:setlist).permit(:name, :setlist_image)
  end

  def find_setlist
    @setlist = Setlist.find(params[:id])
  end

  def set_user_stack_tracks
    @tracks = current_user.stack.tracks
  end

  def find_track
    if Track.find_by_spotify_id(params[:setlist][:track])
      @track = Track.find_by_spotify_id(params[:setlist][:track])
    else
      track = RSpotify::Track.find(params[:setlist][:track])
      album = RSpotify::Album.find(track.album.id)
      @album = Album.create(
        spotify_id: album.id,
        artist: album.artists.first.name,
        title: album.name,
        year: album.release_date,
        cover_image_url: album.images.first["url"]
      )
      @track = Track.find_by_spotify_id(params[:setlist][:track])
    end
  end

end
