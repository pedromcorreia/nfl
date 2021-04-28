defmodule Nfl.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false
  alias Nfl.Repo

  alias Nfl.Statistics.Rushing
  alias Nfl.Helpers.Sanitize

  @doc """
  Returns the list of rushings.

  ## Examples

      iex> list_rushings()
      [%Rushing{}, ...]

  """
  def list_rushings do
    Repo.all(Rushing)
  end

  def sort(query, %{"sort_by" => field, "sort_order" => order})
      when order in ["desc", "asc", :desc, :asc] and not is_nil(field) do
    field = Sanitize.to_atom(field)
    order = Sanitize.to_atom(order)

    (s in query)
    |> from(order_by: {^order, field(s, ^field)})
  end

  def sort(query, _), do: query

  def filter_name(query, %{"query" => value}) when value != "" do
    (s in query)
    |> from(where: ilike(s."Player", ^"%#{value}%"))
  end

  def filter_name(query, _), do: query

  def list_rushings_by_params(params) do
    from(r in Rushing)
    |> filter_name(params)
    |> sort(params)
    |> Repo.all()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rushing changes.

  ## Examples

      iex> change_rushing(rushing)
      %Ecto.Changeset{data: %Rushing{}}

  """
  def change_rushing(%Rushing{} = rushing, attrs \\ %{}) do
    Rushing.changeset(rushing, attrs)
  end
end
