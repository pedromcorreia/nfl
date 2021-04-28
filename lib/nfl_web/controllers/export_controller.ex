defmodule NflWeb.ExportController do
  use NflWeb, :controller

  alias Nfl.Statistics
  alias Nfl.Statistics.Export
  alias Nfl.Helpers.Exporter

  def index(conn, %{"query" => _, "sort_by" => _, "sort_order" => _} = params) do
    exports =
      Statistics.list_rushings_by_params(params)
      |> Exporter.data_to_csv()

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"contacts.csv\"")
    |> send_resp(200, exports)
  end
end
