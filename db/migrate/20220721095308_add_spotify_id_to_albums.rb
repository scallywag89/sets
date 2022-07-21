class AddSpotifyIdToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :spotify_id, :string
  end
end
