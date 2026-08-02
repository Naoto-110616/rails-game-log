class Game < ApplicationRecord
    has_many :game_genres, dependent: :destroy
    has_many :genres, through: :game_genres
  end
