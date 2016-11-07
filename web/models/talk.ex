defmodule PyconarTalks.Talk do
  use PyconarTalks.Web, :model

  alias PyconarTalks.Repo

  schema "talks" do
    field :name, :string
    field :description, :string
    field :votes, :integer
    field :disabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :votes, :disabled])
    |> validate_required([:name, :description, :votes, :disabled])
  end

  def vote!(talk) do
    talk
    |> cast(%{votes: talk.votes+1}, ~w(votes)a)
    |> Repo.update
  end
end
