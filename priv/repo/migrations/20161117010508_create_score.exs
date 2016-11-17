defmodule PyconarTalks.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :user_id, :string
      add :score, :integer
      add :talk_id, references(:talks, on_delete: :nothing)

      timestamps()
    end
    create unique_index(:scores, [:user_id, :talk_id])

  end
end
