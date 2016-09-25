defmodule Concoctify.UnusedIngredient do
  use Concoctify.Web, :model

  schema "unused_ingredients" do
    belongs_to :ingredient_variety, Concoctify.IngredientVariety
    belongs_to :ingredient_producer, Concoctify.IngredientProducer

    timestamps()
  end

  @required_fields ~w(ingredient_variety_id ingredient_producer_id)a
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
    |> foreign_key_constraint(:ingredient_variety_id)
    |> foreign_key_constraint(:ingredient_producer_id)
  end
end
