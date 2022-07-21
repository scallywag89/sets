class AddSpotifyIdToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :spotify_id, :string
  end
end
