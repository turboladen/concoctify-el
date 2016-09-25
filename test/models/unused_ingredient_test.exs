defmodule Concoctify.UnusedIngredientTest do
  use Concoctify.ModelCase

  alias Concoctify.UnusedIngredient

  @valid_attrs %{id: "7488a646-e31f-11e4-aace-600308960662",
   ingredient_producer_id: Ecto.UUID.generate,
   ingredient_variety_id: Ecto.UUID.generate}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UnusedIngredient.changeset(%UnusedIngredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UnusedIngredient.changeset(%UnusedIngredient{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with unknown ingredient_producer_id and ingredient_variety_id" do
    changeset = UnusedIngredient.changeset(%UnusedIngredient{}, @valid_attrs)
    {:error, model} = Repo.insert changeset

    assert model.errors == [
      ingredient_variety_id: {"does not exist", []},
    ]
  end
end
