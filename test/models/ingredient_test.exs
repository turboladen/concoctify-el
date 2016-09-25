defmodule Concoctify.IngredientTest do
  use Concoctify.ModelCase

  alias Concoctify.Repo
  alias Concoctify.Ingredient

  @valid_attrs %{quantity_unit: "some content", quantity_value: "120.5",
    unused_ingredient_id: Ecto.UUID.generate}
  @invalid_attrs %{unused_ingredient_id: 1}

  test "changeset with valid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ingredient.changeset(%Ingredient{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with unknown unused_ingredient_id" do
    changeset = Ingredient.changeset(%Ingredient{}, @valid_attrs)
    {:error, model} = Repo.insert changeset

    assert model.errors == [unused_ingredient_id: {"does not exist", []}]
  end
end
