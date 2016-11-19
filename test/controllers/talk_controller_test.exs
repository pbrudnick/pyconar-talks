defmodule PyconarTalks.TalkControllerTest do
  use PyconarTalks.ConnCase

  alias PyconarTalks.Talk
  @valid_attrs %{description: "some content", tags: "elixir", conf_key: 23, room: "Main", author: "Lambir", start: "11:00AM", disabled: true, name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, talk_path(conn, :index)
    assert json_response(conn, 200)["talks"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = get conn, talk_path(conn, :show, talk)
    assert json_response(conn, 200)["talk"] == %{"id" => talk.id,
      "name" => talk.name,
      "description" => talk.description,
      "tags" => talk.tags,
      "conf_key" => talk.conf_key,
      "room" => talk.room,
      "author" => talk.author,
      "start" => talk.start,
      "disabled" => talk.disabled}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, talk_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @valid_attrs
    assert json_response(conn, 201)["talk"]["id"]
    #assert Repo.get_by(Talk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :skip
  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @valid_attrs
    assert json_response(conn, 200)["talk"]["id"]
    assert Repo.get_by(Talk, @valid_attrs)
  end

  @tag :skip
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :skip
  test "deletes chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = delete conn, talk_path(conn, :delete, talk)
    assert response(conn, 204)
    refute Repo.get(Talk, talk.id)
  end
end
