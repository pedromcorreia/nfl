defmodule Helpers.Sanitize do
  def sanitize(params) when is_map(params) do
    params
    |> Enum.map(&sanitize_attrs/1)
    |> Enum.into(%{})
  end

  def to_atom(params) when is_atom(params), do: params
  def to_atom(params), do: String.to_atom(params)

  defp sanitize_attrs({key, value} = param) when key in ~w(Lng) and not is_bitstring(value) do
    {key, "#{value}"}
  end

  defp sanitize_attrs({key, value} = param) when key in ~w(1st% Att/G Avg Yds/G Yds) do
    with true <- is_bitstring(value),
         String.contains?(value, ",") do
      value = String.replace(value, ",", "") |> String.to_integer()

      {key, value}
    else
      _ -> param
    end
  end

  defp sanitize_attrs(param), do: param
end
