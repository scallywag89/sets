class SetTracksController < ApplicationController
  before_action :find_setlist, :find_track, only: [:create]

  def create
    if !@setlist.track_ids.include?(@track.id)
      @set_track = SetTrack.new(setlist_id: @setlist.id, track_id: @track.id)
      @set_track.save
    else
      redirect_to request.referer, alert: "You already have this track in your setlist!"
    end
  end

  def destroy
    find_settrack
    @set_track.destroy
    redirect_to setlist_path(params[:setlist])
  end

  private

  def set_track_params
    params.require(:set_track).permit(:track_id, :setlist_id)
  end

  def find_setlist
    @setlist = Setlist.find(params[:set_track][:setlist_id])
  end

  def find_track
    if Track.find_by_spotify_id(params[:set_track][:track_id])
      @track = Track.find_by_spotify_id(params[:set_track][:track_id])
    else
      track = RSpotify::Track.find(params[:set_track][:track_id])
      album = RSpotify::Album.find(track.album.id)
      @album = Album.create(
        spotify_id: album.id,
        artist: album.artists.first.name,
        title: album.name,
        year: album.release_date,
        cover_image_url: album.images.first["url"]
      )
      @track = Track.find_by_spotify_id(params[:set_track][:track_id])
    end
  end

  def find_settrack
    @set_track = SetTrack.where(track_id: params[:id], setlist_id: params[:setlist]).first
  end
end
