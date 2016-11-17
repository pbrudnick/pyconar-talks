defmodule PyconarTalks.Talk do
  use PyconarTalks.Web, :model

  alias PyconarTalks.Repo

  schema "talks" do
    field :name, :string
    field :description, :string
    field :tags, :string
    field :conf_key, :integer
    field :room, :string
    field :author, :string
    field :start, :string
    field :disabled, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :tags, :conf_key, :room, :author, :start, :disabled])
    |> validate_required([:name, :description, :disabled])
  end

end
