class SetTracksController < ApplicationController
  before_action :find_setlist, :find_track, only: [:create]

  def create
    @set_track = SetTrack.new(setlist: @setlist, track: @track)
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
    @setlist = Setlist.where(id: params[:setlist_id])
  end

  def find_track
    @track = Track.where(id: params[:track_id])
  end

  def find_settrack
    @set_track = SetTrack.where(id: params[:id])
  end
end
