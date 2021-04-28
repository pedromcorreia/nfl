defmodule NflWeb.ExportControllerTest do
  use NflWeb.ConnCase

  alias Nfl.Statistics

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:export) do
    {:ok, export} = Statistics.create_export(@create_attrs)
    export
  end

  describe "index" do
    test "lists all exports", %{conn: conn} do
      conn = get(conn, Routes.export_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Exports"
    end
  end

  describe "new export" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.export_path(conn, :new))
      assert html_response(conn, 200) =~ "New Export"
    end
  end

  describe "create export" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.export_path(conn, :create), export: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.export_path(conn, :show, id)

      conn = get(conn, Routes.export_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Export"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.export_path(conn, :create), export: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Export"
    end
  end

  describe "edit export" do
    setup [:create_export]

    test "renders form for editing chosen export", %{conn: conn, export: export} do
      conn = get(conn, Routes.export_path(conn, :edit, export))
      assert html_response(conn, 200) =~ "Edit Export"
    end
  end

  describe "update export" do
    setup [:create_export]

    test "redirects when data is valid", %{conn: conn, export: export} do
      conn = put(conn, Routes.export_path(conn, :update, export), export: @update_attrs)
      assert redirected_to(conn) == Routes.export_path(conn, :show, export)

      conn = get(conn, Routes.export_path(conn, :show, export))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, export: export} do
      conn = put(conn, Routes.export_path(conn, :update, export), export: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Export"
    end
  end

  describe "delete export" do
    setup [:create_export]

    test "deletes chosen export", %{conn: conn, export: export} do
      conn = delete(conn, Routes.export_path(conn, :delete, export))
      assert redirected_to(conn) == Routes.export_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.export_path(conn, :show, export))
      end
    end
  end

  defp create_export(_) do
    export = fixture(:export)
    %{export: export}
  end
end
