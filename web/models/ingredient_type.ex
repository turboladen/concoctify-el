defmodule Concoctify.IngredientType do
  use Concoctify.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "ingredient_types" do
    field :name, :string
    has_many :ingredient_varieties, Concoctify.IngredientVariety

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
  end
end
