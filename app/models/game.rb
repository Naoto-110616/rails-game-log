class Game < ApplicationRecord
  has_many :game_genres, dependent: :destroy
  has_many :genres, through: :game_genres

  validates :title, presence: true, length: { maximum: 100 }
  validates :hours, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
