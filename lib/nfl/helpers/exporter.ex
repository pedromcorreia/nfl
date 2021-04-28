defmodule Nfl.Helpers.Exporter do
  NimbleCSV.define(CSVParser, separator: ";", escape: "\"")
  @header ~w(1st 1st% 20+ 40+ Att Att/G Avg FUM Lng Player Pos TD Team Yds Yds/G)a

  def data_to_csv(data) do
    [@header | csv_values(data)]
    |> CSVParser.dump_to_iodata()
  end

  defp csv_values(data) do
    data
    |> Enum.map(fn single_data ->
      single_data
      |> Map.take(@header)
      |> Map.values()
      |> Enum.map(&to_string/1)
    end)
  end
end
