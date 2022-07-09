class TracksController < ApplicationController
  def create
    @track = Track.create(track_params)
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id)
  end
end
