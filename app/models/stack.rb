class Stack < ApplicationRecord
  belongs_to :user
  has_many :stack_albums, dependent: :destroy
  has_many :albums, through: :stack_albums
  has_many :tracks, through: :albums
  validates :user, presence: true
end
