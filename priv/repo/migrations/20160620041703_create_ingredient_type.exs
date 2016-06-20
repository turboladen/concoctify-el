defmodule Concoctify.Repo.Migrations.CreateIngredientType do
  use Ecto.Migration

  def change do
    create table(:ingredient_types, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

    create unique_index(:ingredient_types, [:name])
  end
end
