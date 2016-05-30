defmodule Concoctify.Repo.Migrations.CreateCommodity do
  use Ecto.Migration

  def change do
    create table(:commodities, primary_key: false) do
      add :base_commodity_id, references(:base_commodities, type: :uuid), null: false
      add :commodity_variety_id, references(:commodity_varieties, type: :uuid)
      add :ingredient_producer_id, references(:ingredient_producers, type: :uuid)

      timestamps
    end
  end
end
