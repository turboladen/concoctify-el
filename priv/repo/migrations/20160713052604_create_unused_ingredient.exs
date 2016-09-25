defmodule Concoctify.Repo.Migrations.CreateUnusedIngredient do
  use Ecto.Migration

  def change do
    create table(:unused_ingredients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :ingredient_variety_id, references(:ingredient_varieties, type: :uuid)
      add :ingredient_producer_id, references(:ingredient_producers, type: :uuid)

      timestamps
    end
  end
end
