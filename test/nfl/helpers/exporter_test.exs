defmodule Nfl.Helpers.Exporter.Test do
  use Nfl.DataCase
  import Nfl.Factory
  alias Nfl.Helpers.Exporter

  describe "data_to_csv" do
    test "encode_data/1 returns list with encoded data" do
      assert Exporter.encode_data(insert_list(3, :rushing)) |> length == 4
    end

    test "encode_data/1 returns list with header only" do
      assert Exporter.encode_data([]) |> length == 1
    end
  end
end
