defmodule Concoctify.Repo.Migrations.CreateHoneyVariety do
  use Ecto.Migration

  def change do
    create table(:honey_varieties, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false

      timestamps
    end

    create unique_index(:honey_varieties, [:name])
  end
end
