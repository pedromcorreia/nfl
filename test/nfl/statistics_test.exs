defmodule Nfl.StatisticsTest do
  use Nfl.DataCase
  import Nfl.Factory

  alias Nfl.Statistics

  describe "rushings" do
    test "list_rushings_by_params/0 returns empty list without records" do
      assert Statistics.list_rushings_by_params() == []
    end

    test "list_rushings_by_params/0 returns all rushings without params" do
      rushing = insert_list(3, :rushing)

      assert Statistics.list_rushings_by_params() == rushing
      assert length(Statistics.list_rushings_by_params()) == 3
    end

    test "list_rushings_by_params/1 returns all rushings filtered by query" do
      insert_list(3, :rushing)
      rushing = insert(:rushing, %{Player: "Alex Smith"})

      assert Statistics.list_rushings_by_params(%{"query" => "Alex Smith"}) == [rushing]
      assert length(Statistics.list_rushings_by_params()) == 4
    end

    test "list_rushings_by_params/1 returns all rushings sorted desc" do
      insert_list(3, :rushing, TD: 2)
      rushing = insert(:rushing, %{Player: "Alex Smith", TD: 10})
      insert(:rushing, %{Player: "Tom Brady", TD: 1})

      rushings = Statistics.list_rushings_by_params(%{"sort_order" => "desc", "sort_by" => "TD"})
      assert List.first(rushings) == rushing
      assert length(rushings) == 5
    end

    test "list_rushings_by_params/1 returns all rushings sorted asc" do
      insert_list(3, :rushing, TD: 2)
      insert(:rushing, %{Player: "Alex Smith", TD: 10})
      rushing = insert(:rushing, %{Player: "Tom Brady", TD: 1})

      rushings = Statistics.list_rushings_by_params(%{"sort_order" => "asc", "sort_by" => "TD"})
      assert List.first(rushings) == rushing
      assert length(rushings) == 5
    end

    test "list_rushings_by_params/1 returns all rushings sorted asc, and filtered by query" do
      insert_list(3, :rushing, TD: 2, Player: "Alex Smith")
      insert(:rushing, %{Player: "Joe Montana", TD: 10})
      rushing = insert(:rushing, %{Player: "Joe Flacco", TD: 1})

      rushings =
        Statistics.list_rushings_by_params(%{
          "sort_order" => "asc",
          "sort_by" => "TD",
          "query" => "Joe"
        })

      assert List.first(rushings) == rushing
      assert length(rushings) == 2
    end
  end
end
