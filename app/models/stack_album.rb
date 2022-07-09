class StackAlbum < ApplicationRecord
  belongs_to :stack, foreign_key: "stack_id"
  belongs_to :album, foreign_key: "album_id"
end
