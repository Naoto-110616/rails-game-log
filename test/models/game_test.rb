require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "タイトルがあれば保存できる" do
    game = Game.new(title: "デス・ストランディング", platform: "PS5")
    assert game.save
  end

  test "タイトルがないと保存できない" do
    game = Game.new(platform: "Switch")
    assert_not game.save
  end

  test "プレイ時間が負の数だと保存できない" do
    game = Game.new(title: "テストゲーム", hours: -1)
    assert_not game.save
  end

  test "ジャンルを複数ひもづけられる" do
    game = Game.create!(title: "テストゲーム", platform: "Switch")
    action = Genre.create!(name: "アクション")
    rpg = Genre.create!(name: "RPG")

    game.genres << action
    game.genres << rpg

    assert_equal 2, game.genres.count
    assert_includes game.genres.pluck(:name), "アクション"
  end

  test "ジャンル側からもゲームをたどれる" do
    game = Game.create!(title: "テストゲーム", platform: "Switch")
    genre = Genre.create!(name: "アクション")
    game.genres << genre

    assert_equal 1, genre.games.count
    assert_equal "テストゲーム", genre.games.first.title
  end

  test "ゲームを削除すると中間テーブルのレコードも消える" do
    game = Game.create!(title: "テストゲーム", platform: "Switch")
    genre = Genre.create!(name: "アクション")
    game.genres << genre

    assert_difference "GameGenre.count", -1 do
      game.destroy
    end

    # ジャンル自体は残る
    assert Genre.exists?(genre.id)
  end
end
