defmodule Nfl.StatisticsTest do
  use Nfl.DataCase

  alias Nfl.Statistics

  describe "rushings" do
    alias Nfl.Statistics.Rushing

    @valid_attrs %{"1st": 42, "1st%": 42, "20+": 42, "40+": 42, Att: 42, "Att/G": 120.5, Avg: 120.5, FUM: 42, Lng: "some Lng", Player: "some Player", Pos: "some Pos", TD: 42, Team: "some Team", Yds: 42, "Yds/G": 120.5}
    @update_attrs %{"1st": 43, "1st%": 43, "20+": 43, "40+": 43, Att: 43, "Att/G": 456.7, Avg: 456.7, FUM: 43, Lng: "some updated Lng", Player: "some updated Player", Pos: "some updated Pos", TD: 43, Team: "some updated Team", Yds: 43, "Yds/G": 456.7}
    @invalid_attrs %{"1st": nil, "1st%": nil, "20+": nil, "40+": nil, Att: nil, "Att/G": nil, Avg: nil, FUM: nil, Lng: nil, Player: nil, Pos: nil, TD: nil, Team: nil, Yds: nil, "Yds/G": nil}

    def rushing_fixture(attrs \\ %{}) do
      {:ok, rushing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistics.create_rushing()

      rushing
    end

    test "list_rushings/0 returns all rushings" do
      rushing = rushing_fixture()
      assert Statistics.list_rushings() == [rushing]
    end

    test "get_rushing!/1 returns the rushing with given id" do
      rushing = rushing_fixture()
      assert Statistics.get_rushing!(rushing.id) == rushing
    end

    test "create_rushing/1 with valid data creates a rushing" do
      assert {:ok, %Rushing{} = rushing} = Statistics.create_rushing(@valid_attrs)
      assert rushing.1st == 42
      assert rushing.1st% == 42
      assert rushing.20+ == 42
      assert rushing.40+ == 42
      assert rushing.Att == 42
      assert rushing.Att/G == 120.5
      assert rushing.Avg == 120.5
      assert rushing.FUM == 42
      assert rushing.Lng == "some Lng"
      assert rushing.Player == "some Player"
      assert rushing.Pos == "some Pos"
      assert rushing.TD == 42
      assert rushing.Team == "some Team"
      assert rushing.Yds == 42
      assert rushing.Yds/G == 120.5
    end

    test "create_rushing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistics.create_rushing(@invalid_attrs)
    end

    test "update_rushing/2 with valid data updates the rushing" do
      rushing = rushing_fixture()
      assert {:ok, %Rushing{} = rushing} = Statistics.update_rushing(rushing, @update_attrs)
      assert rushing.1st == 43
      assert rushing.1st% == 43
      assert rushing.20+ == 43
      assert rushing.40+ == 43
      assert rushing.Att == 43
      assert rushing.Att/G == 456.7
      assert rushing.Avg == 456.7
      assert rushing.FUM == 43
      assert rushing.Lng == "some updated Lng"
      assert rushing.Player == "some updated Player"
      assert rushing.Pos == "some updated Pos"
      assert rushing.TD == 43
      assert rushing.Team == "some updated Team"
      assert rushing.Yds == 43
      assert rushing.Yds/G == 456.7
    end

    test "update_rushing/2 with invalid data returns error changeset" do
      rushing = rushing_fixture()
      assert {:error, %Ecto.Changeset{}} = Statistics.update_rushing(rushing, @invalid_attrs)
      assert rushing == Statistics.get_rushing!(rushing.id)
    end

    test "delete_rushing/1 deletes the rushing" do
      rushing = rushing_fixture()
      assert {:ok, %Rushing{}} = Statistics.delete_rushing(rushing)
      assert_raise Ecto.NoResultsError, fn -> Statistics.get_rushing!(rushing.id) end
    end

    test "change_rushing/1 returns a rushing changeset" do
      rushing = rushing_fixture()
      assert %Ecto.Changeset{} = Statistics.change_rushing(rushing)
    end
  end

  describe "rushings" do
    alias Nfl.Statistics.Rushing

    @valid_attrs %{"1st": 42, "1st%": 120.5, "20+": 42, "40+": 42, Att: 42, "Att/G": 120.5, Avg: 120.5, FUM: 42, Lng: "some Lng", Player: "some Player", Pos: "some Pos", TD: 42, Team: "some Team", Yds: 42, "Yds/G": 120.5}
    @update_attrs %{"1st": 43, "1st%": 456.7, "20+": 43, "40+": 43, Att: 43, "Att/G": 456.7, Avg: 456.7, FUM: 43, Lng: "some updated Lng", Player: "some updated Player", Pos: "some updated Pos", TD: 43, Team: "some updated Team", Yds: 43, "Yds/G": 456.7}
    @invalid_attrs %{"1st": nil, "1st%": nil, "20+": nil, "40+": nil, Att: nil, "Att/G": nil, Avg: nil, FUM: nil, Lng: nil, Player: nil, Pos: nil, TD: nil, Team: nil, Yds: nil, "Yds/G": nil}

    def rushing_fixture(attrs \\ %{}) do
      {:ok, rushing} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistics.create_rushing()

      rushing
    end

    test "list_rushings/0 returns all rushings" do
      rushing = rushing_fixture()
      assert Statistics.list_rushings() == [rushing]
    end

    test "get_rushing!/1 returns the rushing with given id" do
      rushing = rushing_fixture()
      assert Statistics.get_rushing!(rushing.id) == rushing
    end

    test "create_rushing/1 with valid data creates a rushing" do
      assert {:ok, %Rushing{} = rushing} = Statistics.create_rushing(@valid_attrs)
      assert rushing.1st == 42
      assert rushing.1st% == 120.5
      assert rushing.20+ == 42
      assert rushing.40+ == 42
      assert rushing.Att == 42
      assert rushing.Att/G == 120.5
      assert rushing.Avg == 120.5
      assert rushing.FUM == 42
      assert rushing.Lng == "some Lng"
      assert rushing.Player == "some Player"
      assert rushing.Pos == "some Pos"
      assert rushing.TD == 42
      assert rushing.Team == "some Team"
      assert rushing.Yds == 42
      assert rushing.Yds/G == 120.5
    end

    test "create_rushing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistics.create_rushing(@invalid_attrs)
    end

    test "update_rushing/2 with valid data updates the rushing" do
      rushing = rushing_fixture()
      assert {:ok, %Rushing{} = rushing} = Statistics.update_rushing(rushing, @update_attrs)
      assert rushing.1st == 43
      assert rushing.1st% == 456.7
      assert rushing.20+ == 43
      assert rushing.40+ == 43
      assert rushing.Att == 43
      assert rushing.Att/G == 456.7
      assert rushing.Avg == 456.7
      assert rushing.FUM == 43
      assert rushing.Lng == "some updated Lng"
      assert rushing.Player == "some updated Player"
      assert rushing.Pos == "some updated Pos"
      assert rushing.TD == 43
      assert rushing.Team == "some updated Team"
      assert rushing.Yds == 43
      assert rushing.Yds/G == 456.7
    end

    test "update_rushing/2 with invalid data returns error changeset" do
      rushing = rushing_fixture()
      assert {:error, %Ecto.Changeset{}} = Statistics.update_rushing(rushing, @invalid_attrs)
      assert rushing == Statistics.get_rushing!(rushing.id)
    end

    test "delete_rushing/1 deletes the rushing" do
      rushing = rushing_fixture()
      assert {:ok, %Rushing{}} = Statistics.delete_rushing(rushing)
      assert_raise Ecto.NoResultsError, fn -> Statistics.get_rushing!(rushing.id) end
    end

    test "change_rushing/1 returns a rushing changeset" do
      rushing = rushing_fixture()
      assert %Ecto.Changeset{} = Statistics.change_rushing(rushing)
    end
  end
end
