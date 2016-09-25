defmodule Concoctify.Ingredient do
  use Concoctify.Web, :model

  schema "ingredients" do
    field :quantity_unit, :string
    field :quantity_value, :float
    belongs_to :unused_ingredient, Concoctify.UnusedIngredient

    timestamps()
  end

  @required_fields ~w(unused_ingredient_id quantity_unit quantity_value)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:unused_ingredient_id)
  end
end
