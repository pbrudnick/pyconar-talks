defmodule PyconarTalks.ScoreControllerTest do
  use PyconarTalks.ConnCase

  alias PyconarTalks.Score
  alias PyconarTalks.Talk
  @valid_attrs %{score: 5}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")
          |> put_req_header("authorization", "SFMyNTY.g3QAAAACZAAEZGF0YWECZAAGc2lnbmVkbgYAOS84hFgB.XcoH23b8Kuz_b90HFHQqzw8HSfxyP7ZRK941ER5Dx5I
.SFMyNTY.g3QAAAACZAAEZGF0YWECZAAGc2lnbmVkbgYATy84hFgB.2BsdX3s9RDyxx4jvIJbz9P_HlN9FDUAyiww65MBIu4U") }
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, score_path(conn, :index)
    assert json_response(conn, 200)["scores"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = get conn, score_path(conn, :show, score)
    assert json_response(conn, 200)["score"] == %{"id" => score.id,
      "user_id" => score.user_id,
      "talk_id" => score.talk_id,
      "score" => score.score}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, score_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    talk = Repo.insert! %Talk{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Joe", start: "11:00AM", disabled: true, name: "some content"}
    conn = post conn, score_path(conn, :create), score: %{score: 5, user_id: "android", talk_id: talk.id}
    assert json_response(conn, 201)["score"]["id"]
    assert Repo.get_by(Score, @valid_attrs)
  end
  
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, score_path(conn, :create), score: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :skip
  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    talk = Repo.insert! %Talk{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Koy", start: "12:00AM", disabled: true, name: "some content"}
    score = Repo.insert! %Score{score: 3, user_id: "android", talk_id: talk.id}
    conn = put conn, score_path(conn, :update, score), score: @valid_attrs
    assert json_response(conn, 200)["score"]["id"]
    assert Repo.get_by(Score, @valid_attrs)
  end

  @tag :skip
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = put conn, score_path(conn, :update, score), score: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :skip
  test "deletes chosen resource", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = delete conn, score_path(conn, :delete, score)
    assert response(conn, 204)
    refute Repo.get(Score, score.id)
  end

  test "lists all the talks by score", %{conn: conn} do
    conn = get conn, score_path(conn, :talks_by_score)
    assert json_response(conn, 200)["scores"] == []
  end
end
