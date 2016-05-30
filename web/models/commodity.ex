defmodule Concoctify.Commodity do
  use Concoctify.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "commodities" do
    belongs_to :commodity_variety, Concoctify.CommodityVariety, type: Ecto.UUID
    belongs_to :ingredient_producer, Concoctify.IngredientProducer, type: Ecto.UUID
    belongs_to :base_commodity, Concoctify.BaseCommodity, type: Ecto.UUID

    timestamps
  end

  @required_fields ~w(base_commodity_id)
  @optional_fields ~w(commodity_variety_id ingredient_producer_id )

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
