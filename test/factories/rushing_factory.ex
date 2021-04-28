defmodule Nfl.RushingFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def rushing_factory do
        %Nfl.Statistics.Rushing{
          "1st": 42,
          "1st%": 120.5,
          "20+": 42,
          "40+": 42,
          Att: 42,
          "Att/G": 120.5,
          Avg: 120.5,
          FUM: 42,
          Lng: "some Lng",
          Player: "some Player",
          Pos: "some Pos",
          TD: 42,
          Team: "some Team",
          Yds: 42,
          "Yds/G": 120.5
        }
      end
    end
  end
end
