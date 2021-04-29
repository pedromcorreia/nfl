defmodule Nfl.Statistics.RushingTest do
  use Nfl.DataCase
  import Nfl.Factory

  alias Nfl.Statistics.Rushing

  describe "changeset/2" do
    test "with valid params retuns valid" do
      changeset = Rushing.changeset(%Rushing{}, params_for(:rushing))
      assert changeset.valid?
    end

    test "with invalid params returns invalid" do
      changeset = Rushing.changeset(%Rushing{}, params_for(:rushing, %{Player: nil}))
      refute changeset.valid?

      changeset = Rushing.changeset(%Rushing{}, %{})
      refute changeset.valid?
    end
  end
end
