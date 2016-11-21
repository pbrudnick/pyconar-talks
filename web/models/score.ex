defmodule PyconarTalks.Score do
  use PyconarTalks.Web, :model

  schema "scores" do
    field :user_id, :string
    field :score, :integer
    belongs_to :talk, PyconarTalks.Talk

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :talk_id, :score])
    |> validate_required([:user_id, :talk_id, :score])
    |> validate_inclusion(:score, 1..5)
    |> foreign_key_constraint(:talk_id, [message: "The talk does not exist"])
    |> unique_constraint(:talk_id_user_id, [name: "scores_user_id_talk_id_index", message: "The user already scored this talk"])
  end

  def group_talks_and_sum_scores(query) do
    from s in query,
    join: t in assoc(s, :talk),
    where: t.id == s.talk_id, 
    group_by: [s.talk_id, t.name, t.author],
    select: %{name: t.name, author: t.author, total: sum(s.score)},
    order_by: sum(s.score)
  end
end
