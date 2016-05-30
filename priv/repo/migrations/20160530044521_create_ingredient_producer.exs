defmodule Concoctify.Repo.Migrations.CreateIngredientProducer do
  use Ecto.Migration

  def change do
    create table(:ingredient_producers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false

      timestamps
    end

    create unique_index(:ingredient_producers, [:name])
  end
end
