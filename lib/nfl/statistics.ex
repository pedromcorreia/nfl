defmodule Nfl.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false
  alias Nfl.Repo

  alias Nfl.Statistics.Rushing
  alias Nfl.Helpers.Sanitize

  @doc """
  Returns the list of rushings by params

  Params are optional, permitted params:

  ["sort_by", "sort_order", "query"]

  ## Examples

      iex> list_rushings_by_params()
      [%Rushing{}, ...]

      iex> list_rushings_by_params(%{"sort_by" => "TD", "sort_order" => "desc"})
      [%Rushing{}, ...]

      iex> list_rushings_by_params(%{"query" => "Alfred Blue"})
      [%Rushing{}, ...]
  """
  def list_rushings_by_params(params \\ %{}) do
    from(r in Rushing)
    |> filter_name(params)
    |> sort(params)
    |> Repo.all()
  end

  defp sort(query, %{"sort_by" => field, "sort_order" => order})
       when order in ["desc", "asc", :desc, :asc] and not is_nil(field) do
    field = Sanitize.to_atom(field)
    order = Sanitize.to_atom(order)

    from(s in query, order_by: {^order, field(s, ^field)})
  end

  defp sort(query, _), do: query

  defp filter_name(query, %{"query" => value}) when value != "" do
    from(s in query, where: ilike(s."Player", ^"%#{value}%"))
  end

  defp filter_name(query, _), do: query
end
