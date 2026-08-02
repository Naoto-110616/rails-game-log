json.extract! game, :id, :title, :platform, :status, :hours, :note, :created_at, :updated_at
json.url game_url(game, format: :json)
