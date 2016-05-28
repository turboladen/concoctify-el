defmodule Concoctify.Repo.Migrations.CreateGeneralIngredient do
  use Ecto.Migration

  def change do
    create table(:general_ingredients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

    create unique_index(:general_ingredients, [:name])
  end
end
