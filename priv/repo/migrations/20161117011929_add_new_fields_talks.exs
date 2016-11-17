defmodule PyconarTalks.Repo.Migrations.AddNewFieldsTalks do
  use Ecto.Migration

  def change do
  	alter table(:talks) do
	  modify :description, :text
	  add :tags, :string
	  add :conf_key, :integer
	  add :room, :string
	  add :author, :string
	  add :start, :string
	  remove :votes
	end
  end
end
