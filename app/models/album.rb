class Album < ApplicationRecord
  has_many :tracks
  has_many :stack_albums, dependent: :destroy
  has_many :stacks, through: :stack_albums

  validates :title, presence: true

  after_create :add_tracks

  private

  def add_tracks
    if RSpotify::Album.find(self)
      album = RSpotify::Album.find(self)
      album.tracks.each do |track|
        Track.create(
          name: track.name,
          album_id: self
        )
      end
    end
  end

end
