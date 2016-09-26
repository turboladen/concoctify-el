defmodule Concoctify.Recipe do
  use Concoctify.Web, :model

  schema "recipes" do
    field :name, :string
    field :description, :string
    field :directions, :string
    field :yields_value, :float
    field :yields_unit, :string
    belongs_to :concoction_type, Concoctify.ConcoctionType
    has_many :ingredients, Concoctify.Ingredient, on_delete: :delete_all
    # has_many :concoctions, Concoctify.Concoction, on_delete: :nilify_all

    timestamps()
  end

  @required_fields ~w(name concoction_type_id)a
  @optional_fields ~w(description directions yields_value yields_unit)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    all_fields = @required_fields ++ @optional_fields

    struct
    |> cast(params, all_fields)
    |> validate_required(@required_fields)
  end
end
