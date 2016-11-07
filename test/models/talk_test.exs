defmodule PyconarTalks.TalkTest do
  use PyconarTalks.ModelCase

  alias PyconarTalks.Talk

  @valid_attrs %{description: "some content", disabled: true, name: "some content", votes: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Talk.changeset(%Talk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Talk.changeset(%Talk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
