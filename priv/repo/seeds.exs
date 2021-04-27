# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Nfl.Repo.insert!(%Nfl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

json_file = "#{__DIR__}/rushing.json"

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body) do
  Enum.each(json, fn player ->
    %Nfl.Statistics.Rushing{}
    |> Nfl.Statistics.change_rushing(Helpers.Sanitize.sanitize(player))
    |> Nfl.Repo.insert!()
  end)
end
