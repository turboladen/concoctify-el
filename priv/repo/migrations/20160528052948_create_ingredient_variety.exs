defmodule Concoctify.Repo.Migrations.CreateIngredientVariety do
  use Ecto.Migration

  def change do
    create table(:ingredient_varieties, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :general_ingredient_id, references(:general_ingredients, type: :uuid)

      timestamps
    end
  end
end
