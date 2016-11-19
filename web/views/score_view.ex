defmodule PyconarTalks.ScoreView do
  use PyconarTalks.Web, :view

  def render("index.json", %{scores: scores}) do
    %{scores: render_many(scores, PyconarTalks.ScoreView, "score.json")}
  end

  def render("talks_by_score.json", %{scores: scores}) do
    %{scores: render_many(scores, PyconarTalks.ScoreView, "talks_score.json")}
  end

  def render("show.json", %{score: score}) do
    %{score: render_one(score, PyconarTalks.ScoreView, "score.json")}
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      user_id: score.user_id,
      talk_id: score.talk_id,
      score: score.score}
  end

  def render("talks_score.json", %{score: score}) do
    %{talk: score.name,
      author: score.author,
      total: score.total}
  end
end
