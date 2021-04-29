defmodule Nfl.Helpers.Sanitize do
  @moduledoc """
  The module sanitize to help removing or converting data
  into other data type.
  """

  @doc """
  Returns a map for given map, removing and converting some data, as:
  string in integer.

  Returns `%{}`.

  ## Examples

      iex> sanitize(%{"1st" => 2,
                      "1st%" => 33.3,
                      "20+" => 1,
                      "40+" => 0,
                      "Att" => 6,
                      "Att/G" => 0.4,
                      "Avg" => 7.2,
                      "FUM" => 1,
                      "Lng" => "29",
                      "Player" => "Johnny Holton",
                      "Pos" => "WR",
                      "TD" => 0,
                      "Team" => "OAK",
                      "Yds" => "1,143",
                      "Yds/G" => 2.9})
      %{
        "1st" => 2,
        "1st%" => 33.3,
        "20+" => 1,
        "40+" => 0,
        "Att" => 6,
        "Att/G" => 0.4,
        "Avg" => 7.2,
        "FUM" => 1,
        "Lng" => "29",
        "Player" => "Johnny Holton",
        "Pos" => "WR",
        "TD" => 0,
        "Team" => "OAK",
        "Yds" => 1143,
        "Yds/G" => 2.9
      }

  """
  @spec sanitize(map()) :: map()
  def sanitize(params) when is_map(params) do
    params
    |> Enum.map(&sanitize_attrs/1)
    |> Enum.into(%{})
  end

  @doc """
  Returns a atom, for given params:

  Returns `atom`.

  ## Examples

      iex> to_atom(:Player)
      :Player

      iex> to_atom("Player")
      :Player

  """
  @spec to_atom(atom() | String.t()) :: atom()
  def to_atom(params) when is_atom(params), do: params
  def to_atom(params), do: String.to_atom(params)

  defp sanitize_attrs({key, value}) when key in ~w(Lng) and not is_bitstring(value) do
    {key, to_string(value)}
  end

  defp sanitize_attrs({key, value} = param) when key in ~w(1st% Att/G Avg Yds/G Yds) do
    with true <- is_bitstring(value),
         true <- String.contains?(value, ",") do
      value = String.replace(value, ",", "") |> String.to_integer()

      {key, value}
    else
      _ -> param
    end
  end

  defp sanitize_attrs(param), do: param
end
