defmodule Concoctify.IngredientVarietyTest do
  use Concoctify.ModelCase

  alias Concoctify.IngredientVariety

  @valid_attrs %{general_ingredient_id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = IngredientVariety.changeset(%IngredientVariety{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientVariety.changeset(%IngredientVariety{}, @invalid_attrs)
    refute changeset.valid?
  end
end
