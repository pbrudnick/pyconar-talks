defmodule PyconarTalks.ScoreController do
  use PyconarTalks.Web, :controller

  alias PyconarTalks.Score

  def index(conn, _params) do
    scores = Repo.all(Score)
    render(conn, "index.json", scores: scores)
  end

  def talks_by_score(conn, params) do
    scores = Score  
      |> Score.group_talks_and_sum_scores
      |> Repo.all
    render(conn, "talks_by_score.json", scores: scores)
  end

  def create(conn, %{"score" => score_params}) do
    changeset = Score.changeset(%Score{}, score_params)
    token = Phoenix.Token.sign(conn, "user", 2)
    IO.puts Plug.Conn.get_req_header(conn, "authorization")
    #case Phoenix.Token.verify(conn, "user", token) do
    case Phoenix.Token.verify(conn, "user", Plug.Conn.get_req_header(conn, "authorization")) do
      {:ok, user_id} ->
        case Repo.insert(changeset) do
          {:ok, score} ->
            conn
            |> put_status(:created)
            |> put_resp_header("location", score_path(conn, :show, score))
            |> render("show.json", score: score)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
        end
      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Repo.get!(Score, id)
    render(conn, "show.json", score: score)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Repo.get!(Score, id)
    changeset = Score.changeset(score, score_params)

    case Repo.update(changeset) do
      {:ok, score} ->
        render(conn, "show.json", score: score)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PyconarTalks.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Repo.get!(Score, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(score)

    send_resp(conn, :no_content, "")
  end
end
