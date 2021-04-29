defmodule Nfl.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Nfl.Repo

  use Nfl.{
    RushingFactory
  }
end
