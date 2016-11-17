defmodule PyconarTalks.ScoreView do
  use PyconarTalks.Web, :view

  def render("index.json", %{scores: scores}) do
    %{data: render_many(scores, PyconarTalks.ScoreView, "score.json")}
  end

  def render("show.json", %{score: score}) do
    %{data: render_one(score, PyconarTalks.ScoreView, "score.json")}
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      user_id: score.user_id,
      talk_id: score.talk_id,
      score: score.score}
  end
end
