defmodule Nfl.Statistics.Rushing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rushings" do
    field :"1st", :integer
    field :"1st%", :float
    field :"20+", :integer
    field :"40+", :integer
    field :Att, :integer
    field :"Att/G", :float
    field :Avg, :float
    field :FUM, :integer
    field :Lng, :string
    field :Player, :string
    field :Pos, :string
    field :TD, :integer
    field :Team, :string
    field :Yds, :integer
    field :"Yds/G", :float

    timestamps()
  end

  @doc false
  def changeset(rushing, attrs) do
    rushing
    |> cast(attrs, [:"1st", :"1st%", :"20+", :"40+", :Att, :"Att/G", :FUM, :Lng, :Player, :Pos, :TD, :Team, :Yds, :"Yds/G", :Avg])
    |> validate_required([:"1st", :"1st%", :"20+", :"40+", :Att, :"Att/G", :FUM, :Lng, :Player, :Pos, :TD, :Team, :Yds, :"Yds/G", :Avg])
  end
end
