defmodule Concoctify.Honey do
  use Concoctify.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "honeies" do
    belongs_to :honey_variety, Concoctify.HoneyVariety, type: Ecto.UUID
    belongs_to :ingredient_producer, Concoctify.IngredientProducer, type: Ecto.UUID

    timestamps
  end

  @required_fields ~w(honey_variety_id ingredient_producer_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
