defmodule PyconarTalks.TalkView do
  use PyconarTalks.Web, :view

  def render("index.json", %{talks: talks}) do
    %{data: render_many(talks, PyconarTalks.TalkView, "talk.json")}
  end

  def render("show.json", %{talk: talk}) do
    %{data: render_one(talk, PyconarTalks.TalkView, "talk.json")}
  end

  def render("talk.json", %{talk: talk}) do
    %{id: talk.id,
      name: talk.name,
      description: talk.description,
      votes: talk.votes,
      disabled: talk.disabled}
  end
end
