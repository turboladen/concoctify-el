defmodule Concoctify.Repo.Migrations.CreateCommodityVariety do
  use Ecto.Migration

  def change do
    create table(:commodity_varieties, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :base_commodity_id, references(:base_commodities, type: :uuid), null: false

      timestamps
    end
  end
end
