defmodule Concoctify.Repo.Migrations.CreateCommodity do
  use Ecto.Migration

  def change do
    create table(:commodities, primary_key: false) do
      add :name, :string
      add :id, :uuid, primary_key: true

      timestamps
    end

    create unique_index(:commodities, [:name])
  end
end
