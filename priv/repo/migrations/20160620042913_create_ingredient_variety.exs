defmodule Concoctify.Repo.Migrations.CreateIngredientVariety do
  use Ecto.Migration

  def change do
    create table(:ingredient_varieties, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :ingredient_type_id, references(:ingredient_types, type: :uuid)

      timestamps
    end

    create index(:ingredient_varieties, [:name])
  end
end
