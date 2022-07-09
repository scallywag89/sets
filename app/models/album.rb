class Album < ApplicationRecord
  has_many :tracks
  has_many :stack_albums, dependent: :destroy
  has_many :stacks, thorugh: :stack_albums

  validates :title, presence: true
end
