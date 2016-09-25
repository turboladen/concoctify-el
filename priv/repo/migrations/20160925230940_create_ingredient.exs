defmodule Concoctify.Repo.Migrations.CreateIngredient do
  use Ecto.Migration

  def change do
    create table(:ingredients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :quantity_unit, :string
      add :quantity_value, :float
      add :unused_ingredient_id, references(:unused_ingredients, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:ingredients, [:unused_ingredient_id])
  end
end
