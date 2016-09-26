defmodule Concoctify.ConcoctionType do
  use Concoctify.Web, :model

  schema "concoction_types" do
    field :name, :string

    timestamps()
  end

  @required_fields ~w(name)a
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end

  @doc """
  Gets all name/ID pairs, specifically for using in drop-downs.
  """
  def names do
    query = from ct in Concoctify.ConcoctionType, select: {ct.name, ct.id}
    Concoctify.Repo.all(query)
  end
end
