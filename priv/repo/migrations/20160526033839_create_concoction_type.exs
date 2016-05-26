defmodule Concoctify.Repo.Migrations.CreateConcoctionType do
  use Ecto.Migration

  def change do
    create table(:concoction_types, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

    create unique_index(:concoction_types, [:name])
  end
end
