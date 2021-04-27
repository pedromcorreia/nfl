defmodule Nfl.Repo.Migrations.CreateRushings do
  use Ecto.Migration

  def change do
    create table(:rushings) do
      add :"1st", :integer
      add :"1st%", :float
      add :"20+", :integer
      add :"40+", :integer
      add :Att, :integer
      add :"Att/G", :float
      add :FUM, :integer
      add :Lng, :string
      add :Player, :string
      add :Pos, :string
      add :TD, :integer
      add :Team, :string
      add :Yds, :integer
      add :"Yds/G", :float
      add :Avg, :float

      timestamps()
    end

  end
end
