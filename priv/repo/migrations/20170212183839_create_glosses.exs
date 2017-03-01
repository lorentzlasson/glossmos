defmodule Glossmos.Repo.Migrations.CreateGlosses do
  use Ecto.Migration

  def change do
    create table(:glosses) do
      add :language, :string
      add :text, :string
      add :key, :string

      timestamps()
    end
  end
end
