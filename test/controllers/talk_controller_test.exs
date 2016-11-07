defmodule PyconarTalks.TalkControllerTest do
  use PyconarTalks.ConnCase

  alias PyconarTalks.Talk
  @valid_attrs %{description: "some content", disabled: true, name: "some content", votes: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, talk_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = get conn, talk_path(conn, :show, talk)
    assert json_response(conn, 200)["data"] == %{"id" => talk.id,
      "name" => talk.name,
      "description" => talk.description,
      "votes" => talk.votes,
      "disabled" => talk.disabled}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, talk_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    #assert Repo.get_by(Talk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Talk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "votes to a talk", %{conn: conn} do
    talk = Repo.insert! %Talk{votes: 0}
    conn = post conn, talk_path(conn, :vote, talk)
    assert json_response(conn, 200)["data"]["votes"] == 1
  end

  test "votes to a talk with 1 vote", %{conn: conn} do
    talk = Repo.insert! %Talk{votes: 1}
    conn = post conn, talk_path(conn, :vote, talk)
    assert json_response(conn, 200)["data"]["votes"] == 2
  end

  test "deletes chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = delete conn, talk_path(conn, :delete, talk)
    assert response(conn, 204)
    refute Repo.get(Talk, talk.id)
  end
end
