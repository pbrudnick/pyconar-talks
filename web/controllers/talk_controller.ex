defmodule PyconarTalks.TalkController do
  use PyconarTalks.Web, :controller

  alias PyconarTalks.Talk

  def index(conn, _params) do
    talks = Repo.all(Talk)
    render(conn, "index.json", talks: talks)
  end

  def create(conn, %{"talk" => talk_params}) do
    changeset = Talk.changeset(%Talk{}, talk_params)

    case Repo.insert(changeset) do
      {:ok, talk} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", talk_path(conn, :show, talk))
        |> render("show.json", talk: talk)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)
    render(conn, "show.json", talk: talk)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}) do
    talk = Repo.get!(Talk, id)
    changeset = Talk.changeset(talk, talk_params)

    case Repo.update(changeset) do
      {:ok, talk} ->
        render(conn, "show.json", talk: talk)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def vote(conn, params) do
    talk = Repo.get!(Talk, params["talk_id"])
    
    case Talk.vote!(talk) do
      {:ok, talk} ->
        render(conn, "show.json", talk: talk)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(talk)

    send_resp(conn, :no_content, "")
  end
end
