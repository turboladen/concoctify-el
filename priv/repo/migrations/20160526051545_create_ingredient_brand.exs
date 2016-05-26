defmodule Concoctify.Repo.Migrations.CreateIngredientBrand do
  use Ecto.Migration

  def change do
    create table(:ingredient_brands, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

    create unique_index(:ingredient_brands, [:name])
  end
end
