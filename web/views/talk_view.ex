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
      tags: talk.tags,
      conf_key: talk.conf_key,
      room: talk.room,
      author: talk.author,
      start: talk.start,
      disabled: talk.disabled}
  end
end
