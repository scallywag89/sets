class Track < ApplicationRecord
  belongs_to :album
  has_many :set_tracks, dependent: :destroy
  has_many :setlists, through: :set_tracks

  validates :album, presence: true
end
