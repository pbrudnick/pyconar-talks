defmodule PyconarTalks.Repo.Migrations.CreateTalk do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :name, :string
      add :description, :string
      add :votes, :integer
      add :disabled, :boolean, default: false, null: false

      timestamps()
    end

  end
end
