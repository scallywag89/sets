class CreateSetTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :set_tracks do |t|
      t.references :track, null: false, foreign_key: true
      t.references :setlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
