defmodule Concoctify.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :string
      add :directions, :string
      add :yields_value, :float
      add :yields_unit, :string
      add :concoction_type_id, references(:concoction_types, type: :uuid, on_delete: :delete_all)

      timestamps()
    end

    create index(:recipes, [:concoction_type_id])
  end
end
