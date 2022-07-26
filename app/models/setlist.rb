class Setlist < ApplicationRecord
  belongs_to :user
  has_many :set_tracks, dependent: :destroy
  has_many :tracks, through: :set_tracks
  has_one_attached :setlist_image

  validates :name, presence: true
end
