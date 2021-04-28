defmodule NflWeb.RushingLiveTest do
  use NflWeb.ConnCase
  import Phoenix.LiveViewTest
  import Nfl.Factory

  describe "Index" do
    test "disconnected and connected render", %{conn: conn} do
      {:ok, page_live, disconnected_html} = live(conn, "/")

      assert disconnected_html =~ "Players statistics"
      assert render(page_live) =~ "Players statistics"
    end

    test "lists empty screen without data", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Listing Rushings"
      assert html =~ "Download"
      refute html =~ "Alex Smith"
    end

    test "lists all rushings with data", %{conn: conn} do
      insert(:rushing, %{Player: "Alex Smith"})

      {:ok, _index_live, html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Listing Rushings"
      assert html =~ "Alex Smith"
    end

    test "filter rushings data", %{conn: conn} do
      insert(:rushing, %{Player: "Alex Smith"})
      insert(:rushing, %{Player: "Cairo Santos"})

      {:ok, index_live, html} = live(conn, Routes.rushing_index_path(conn, :index))

      assert html =~ "Listing Rushings"
      assert html =~ "Alex Smith"

      assert index_live |> element("#phx_search") |> render_change(%{query: "Alex"}) =~
               "Alex Smith"

      assert index_live |> element("#phx_search") |> render_change(%{query: "Not Valid Player"}) =~
               ""

      refute index_live |> element("#phx_search") |> render_change(%{query: "Alex"}) =~
               "Cairo Santos"
    end
  end
end
