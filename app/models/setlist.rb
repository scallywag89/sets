class Setlist < ApplicationRecord
  belongs_to :user
  has_many :set_tracks, dependent: :destroy
  has_many :tracks, through: :set_tracks

  validates :name, presence: true
end
