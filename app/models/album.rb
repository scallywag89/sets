class Album < ApplicationRecord
  has_many :tracks
  has_many :stack_albums, dependent: :destroy
  has_many :stacks, through: :stack_albums

  validates :title, presence: true

  after_create :add_tracks

  acts_as_favoritable

  private

  def add_tracks
    if RSpotify::Album.find(spotify_id)
      album = RSpotify::Album.find(spotify_id)
      album.tracks.each do |track|
        Track.create(
          spotify_id: track.id,
          name: track.name,
          album: self,
          duration: TimeConvert.milliseconds_to_minutes_and_seconds(track.duration_ms)
        )
      end
    end
  end

end
