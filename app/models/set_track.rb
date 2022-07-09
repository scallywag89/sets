class SetTrack < ApplicationRecord
  belongs_to :track, foreign_key: "track_id"
  belongs_to :setlist, foreign_key: "setlist_id"
end
