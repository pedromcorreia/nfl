defmodule NflWeb.RushingLive.Index do
  use NflWeb, :live_view

  alias Nfl.Statistics
  alias Nfl.Statistics.Rushing
  @allow_params ~w(Lng TD Yds)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rushings, Statistics.list_rushings())}
  end

  @impl true
  def handle_params(%{"sort_by" => key, "sort_order" => order} = params, _url, socket)
      when key in @allow_params and order in ~w(desc asc) do
    {:noreply,
     apply_action(socket, socket.assigns.live_action, params, Statistics.sort(key, order))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rushings")
    |> assign(:rushing, nil)
    |> assign(:sort_by, nil)
    |> assign(:sort_order, :desc)
  end

  defp apply_action(socket, :index, params, rushings) do
    socket
    |> assign(:page_title, "Listing Rushings")
    |> assign(:rushing, nil)
    |> assign(:sort_by, params["sort_by"])
    |> assign(:sort_order, sort_order(params["sort_order"]))
    |> assign(:rushings, rushings)
  end

  defp sort_order_icon(column, sort_by, :asc) when column == sort_by, do: "▲"
  defp sort_order_icon(column, sort_by, :desc) when column == sort_by, do: "▼"
  defp sort_order_icon(column, _, _), do: ""

  defp sort_order("asc"), do: :desc
  defp sort_order("desc"), do: :asc
end
