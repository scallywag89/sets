class CreateStackAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :stack_albums do |t|
      t.references :stack, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
