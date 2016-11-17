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
    |> unique_constraint(:talk_id_user_id, name: "scores_user_id_talk_id_index")
  end
end
