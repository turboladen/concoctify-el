defmodule Concoctify.Repo.Migrations.AddUniqueIndexOnNameAndIngredientType do
  use Ecto.Migration

  def change do
    create index(:ingredient_varieties, [:name, :ingredient_type_id], unique: true)
  end
end
