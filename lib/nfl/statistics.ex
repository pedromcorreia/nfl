defmodule Nfl.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false
  alias Nfl.Repo

  alias Nfl.Statistics.Rushing

  @doc """
  Returns the list of rushings.

  ## Examples

      iex> list_rushings()
      [%Rushing{}, ...]

  """
  def list_rushings do
    Repo.all(Rushing)
  end

  def sort(field, order) when order in ~w(desc asc) do
    field = String.to_atom(field)
    order = String.to_atom(order)

    (s in from(r in Rushing))
    |> from(order_by: {^order, field(s, ^field)})
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
