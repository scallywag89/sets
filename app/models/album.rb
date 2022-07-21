class Album < ApplicationRecord
  has_many :tracks
  has_many :stack_albums, dependent: :destroy
  has_many :stacks, through: :stack_albums

  validates :title, presence: true

  after_create :add_tracks

  private

  def add_tracks
    self.save
    if RSpotify::Album.find(spotify_id)
      album = RSpotify::Album.find(spotify_id)
      album.tracks.each do |track|
        Track.create(
          spotify_id: track.id,
          name: track.name,
          album_id: self.id
        )
      end
    end
  end

end
