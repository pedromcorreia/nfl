defmodule NflWeb.ExportControllerTest do
  use NflWeb.ConnCase
  import Nfl.Factory

  describe "index" do
    test "export current list", %{conn: conn} do
      insert_list(3, :rushing, TD: 2)
      insert(:rushing, %{Player: "Alex Smith", TD: 10})
      insert(:rushing, %{Player: "Tom Brady", TD: 1})

      conn =
        get(conn, Routes.export_path(conn, :index), %{
          "sort_order" => "asc",
          "sort_by" => "TD",
          "query" => ""
        })

      assert Map.get(conn, :status) == 200
      assert Map.get(conn, :resp_body)
    end
  end
end
