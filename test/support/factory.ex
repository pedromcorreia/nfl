defmodule Nfl.Factory do
  use ExMachina.Ecto, repo: Nfl.Repo

  use Nfl.{
    RushingFactory
  }
end
