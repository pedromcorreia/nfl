defmodule NflWeb.RushingLiveTest do
  use NflWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Nfl.Statistics

  @create_attrs %{"1st": 42, "1st%": 120.5, "20+": 42, "40+": 42, Att: 42, "Att/G": 120.5, Avg: 120.5, FUM: 42, Lng: "some Lng", Player: "some Player", Pos: "some Pos", TD: 42, Team: "some Team", Yds: 42, "Yds/G": 120.5}
  @update_attrs %{"1st": 43, "1st%": 456.7, "20+": 43, "40+": 43, Att: 43, "Att/G": 456.7, Avg: 456.7, FUM: 43, Lng: "some updated Lng", Player: "some updated Player", Pos: "some updated Pos", TD: 43, Team: "some updated Team", Yds: 43, "Yds/G": 456.7}
  @invalid_attrs %{"1st": nil, "1st%": nil, "20+": nil, "40+": nil, Att: nil, "Att/G": nil, Avg: nil, FUM: nil, Lng: nil, Player: nil, Pos: nil, TD: nil, Team: nil, Yds: nil, "Yds/G": nil}

  defp fixture(:rushing) do
    {:ok, rushing} = Statistics.create_rushing(@create_attrs)
    rushing
  end

  defp create_rushing(_) do
    rushing = fixture(:rushing)
    %{rushing: rushing}
  end

  describe "Index" do
    setup [:create_rushing]

    test "lists all rushings", %{conn: conn, rushing: rushing} do
      {:ok, _index_live, html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Listing Rushings"
      assert html =~ rushing.Lng
    end

    test "saves new rushing", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert index_live |> element("a", "New Rushing") |> render_click() =~
               "New Rushing"

      assert_patch(index_live, Routes.rushing_index_path(conn, :new))

      assert index_live
             |> form("#rushing-form", rushing: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rushing-form", rushing: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Rushing created successfully"
      assert html =~ "some Lng"
    end

    test "updates rushing in listing", %{conn: conn, rushing: rushing} do
      {:ok, index_live, _html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert index_live |> element("#rushing-#{rushing.id} a", "Edit") |> render_click() =~
               "Edit Rushing"

      assert_patch(index_live, Routes.rushing_index_path(conn, :edit, rushing))

      assert index_live
             |> form("#rushing-form", rushing: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rushing-form", rushing: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Rushing updated successfully"
      assert html =~ "some updated Lng"
    end

    test "deletes rushing in listing", %{conn: conn, rushing: rushing} do
      {:ok, index_live, _html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert index_live |> element("#rushing-#{rushing.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rushing-#{rushing.id}")
    end
  end

  describe "Show" do
    setup [:create_rushing]

    test "displays rushing", %{conn: conn, rushing: rushing} do
      {:ok, _show_live, html} = live(conn, Routes.rushing_show_path(conn, :show, rushing))

      assert html =~ "Show Rushing"
      assert html =~ rushing.Lng
    end

    test "updates rushing within modal", %{conn: conn, rushing: rushing} do
      {:ok, show_live, _html} = live(conn, Routes.rushing_show_path(conn, :show, rushing))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rushing"

      assert_patch(show_live, Routes.rushing_show_path(conn, :edit, rushing))

      assert show_live
             |> form("#rushing-form", rushing: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rushing-form", rushing: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rushing_show_path(conn, :show, rushing))

      assert html =~ "Rushing updated successfully"
      assert html =~ "some updated Lng"
    end
  end
end
