defmodule Concoctify.Repo.Migrations.CreateBaseCommodity do
  use Ecto.Migration

  def change do
    create table(:base_commodities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false

      timestamps
    end

    create unique_index(:base_commodities, [:name])
  end
end
