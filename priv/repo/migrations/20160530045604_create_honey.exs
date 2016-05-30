defmodule Concoctify.Repo.Migrations.CreateHoney do
  use Ecto.Migration

  def change do
    create table(:honeies) do
      add :honey_variety_id, references(:honey_varieties, type: :uuid), null: false
      add :ingredient_producer_id, references(:ingredient_producers, type: :uuid), null: false

      timestamps
    end

  end
end
