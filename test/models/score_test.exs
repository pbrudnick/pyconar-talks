defmodule PyconarTalks.ScoreTest do
  use PyconarTalks.ModelCase

  alias PyconarTalks.Score
  alias PyconarTalks.Talk

  @valid_attrs %{score: 4}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    talk = Repo.insert! %Talk{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Koy", start: "12:00AM", disabled: true, name: "some content"}
    changeset = Score.changeset(%Score{}, %{user_id: "deviceX", talk_id: talk.id, score: 2})
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Score.changeset(%Score{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with a not valid a score" do
    talk = Repo.insert! %Talk{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Koy", start: "12:00AM", disabled: true, name: "some content"}
    changeset = Score.changeset(%Score{}, %{user_id: "deviceX", talk_id: talk.id, score: 6})
    refute changeset.valid?
    assert changeset.errors[:score] == {"is invalid", []}
  end

  test "changeset is invalid if user_id and talk_id are not unique" do
    talk = Repo.insert! %Talk{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Koy", start: "12:00AM", disabled: true, name: "some content"}
    %Score{}
      |> Score.changeset(%{user_id: "deviceX", talk_id: talk.id, score: 2})
      |> Repo.insert!
    score2 =
      %Score{}
      |> Score.changeset(%{user_id: "deviceX", talk_id: talk.id, score: 2})
    assert {:error, changeset} = Repo.insert(score2)
    assert changeset.errors[:talk_id_user_id] == {"has already been taken", []}
  end
end
