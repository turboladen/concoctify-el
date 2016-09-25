defmodule Concoctify.IngredientVariety do
  use Concoctify.Web, :model

  schema "ingredient_varieties" do
    field :name, :string
    belongs_to :ingredient_type, Concoctify.IngredientType

    timestamps
  end

  @required_fields ~w(name ingredient_type_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
