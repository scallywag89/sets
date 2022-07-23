class SetTracksController < ApplicationController
  before_action :find_setlist, :find_track, only: [:create]

  def create
    @set_track = SetTrack.new(setlist_id: @setlist.id, track_id: @track.id)
    @set_track.save
  end

  def destroy
    find_settrack
    @set_track.destroy
  end

  private

  def set_tracks_params
    params.require(:set_tracks).permit(:track_id, :setlist_id)
  end

  def find_setlist
    @setlist = Setlist.find(params[:setlist_id])
  end

  def find_track
    if Track.find_by_spotify_id(params[:track_id])
      @track = Track.find_by_spotify_id(params[:track_id])
    else
      track = RSpotify::Track.find(params[:track_id])
      album = RSpotify::Album.find(track.album.id)
      @album = Album.create(
        spotify_id: album.id,
        artist: album.artists.first.name,
        title: album.name,
        year: album.release_date,
        cover_image_url: album.images.first["url"]
      )
      @track = Track.find_by_spotify_id(params[:track_id])
    end
  end

  def find_settrack
    @set_track = SetTrack.where(id: params[:id])
  end
end
