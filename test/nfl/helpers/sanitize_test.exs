defmodule Nfl.Helpers.Sanitize.Test do
  use Nfl.DataCase
  alias Nfl.Helpers.Sanitize

  describe "encode_data/1" do
    test "encode_data/1 returns data sanitized" do
      assert Sanitize.sanitize(%{"Yds" => "1,267"}) == %{"Yds" => 1267}
    end

    test "encode_data/1 returns data not sanitized when key is Lng" do
      assert Sanitize.sanitize(%{"Lng" => "1,267"}) == %{"Lng" => "1,267"}
      assert Sanitize.sanitize(%{"Lng" => 1267}) == %{"Lng" => "1267"}
    end

    test "encode_data/1 returns data not sanitized with key" do
      assert Sanitize.sanitize(%{"1st%" => 1267}) == %{"1st%" => 1267}
    end
  end

  describe "to_atom/1" do
    test "to_atom/1 send string returns atom" do
      assert Sanitize.to_atom("Player") == :Player
    end

    test "to_atom/1 send atom returns atom" do
      assert Sanitize.to_atom(:Player) == :Player
    end
  end
end
