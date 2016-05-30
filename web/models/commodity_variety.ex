defmodule Concoctify.CommodityVariety do
  use Concoctify.Web, :model
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "commodity_varieties" do
    field :name, :string
    belongs_to :base_commodity, Concoctify.BaseCommodity, type: Ecto.UUID

    timestamps
  end

  @required_fields ~w(name base_commodity_id)
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
