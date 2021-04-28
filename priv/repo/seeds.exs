json_file = "#{__DIR__}/rushing.json"

alias Nfl.Statistics.Rushing
alias Nfl.Helpers.Sanitize

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body) do
  Enum.each(json, fn player ->
    %Rushing{}
    |> Rushing.changeset(Sanitize.sanitize(player))
    |> Nfl.Repo.insert!()
  end)
end
