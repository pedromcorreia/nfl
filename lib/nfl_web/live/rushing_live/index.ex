defmodule NflWeb.RushingLive.Index do
  @moduledoc false
  use NflWeb, :live_view

  alias Nfl.Statistics
  @allow_params ~w(Lng TD Yds)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rushings, rushings_list(socket))}
  end

  @impl true
  def handle_params(%{"sort_by" => key, "sort_order" => order} = params, _url, socket)
      when key in @allow_params and order in ~w(desc asc) do
    {:noreply,
     apply_action(socket, socket.assigns.live_action, params, rushings_list(socket, params))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("search", %{"query" => _query} = params, socket) do
    {:noreply,
     apply_action(socket, socket.assigns.live_action, params, rushings_list(socket, params))}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:sort_by, "TD")
    |> assign(:query, "")
    |> assign(:sort_order, :desc)
  end

  defp apply_action(socket, :index, params, rushings) do
    socket
    |> assign(:query, params["query"] || socket.assigns[:query])
    |> assign(:sort_order, sort_order(params["sort_order"]) || socket.assigns[:sort_order])
    |> assign(:sort_by, params["sort_by"] || socket.assigns[:sort_by])
    |> assign(:rushings, rushings)
  end

  defp rushings_list(socket, params \\ %{})

  defp rushings_list(_socket, %{"query" => _} = params) do
    Statistics.list_rushings_by_params(params)
  end

  defp rushings_list(socket, params) do
    params = Map.put(params, "query", socket.assigns[:query])
    Statistics.list_rushings_by_params(params)
  end

  defp sort_order_icon(column, sort_by, :asc) when column == sort_by, do: "▲"
  defp sort_order_icon(column, sort_by, :desc) when column == sort_by, do: "▼"
  defp sort_order_icon(_column, _, _), do: ""

  defp sort_order("asc"), do: :desc
  defp sort_order("desc"), do: :asc
  defp sort_order(_), do: :desc
end
