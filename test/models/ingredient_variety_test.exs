defmodule Concoctify.IngredientVarietyTest do
  use Concoctify.ModelCase

  alias Concoctify.Repo
  alias Concoctify.IngredientVariety
  alias Concoctify.IngredientType

  @valid_attrs %{id: "7488a646-e31f-11e4-aace-600308960662", name: "some content",
    ingredient_type_id: Ecto.UUID.generate}
  @invalid_attrs %{things: 1}

  test "changeset with valid attributes" do
    changeset = IngredientVariety.changeset(%IngredientVariety{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientVariety.changeset(%IngredientVariety{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name/ingredient_type combo" do
    type_changeset = IngredientType.changeset(%IngredientType{}, %{name: "Typey Type"})
    {:ok, type_model} = Repo.insert type_changeset
    valid_attrs = Map.merge(@valid_attrs, %{ingredient_type_id: type_model.id})

    changeset1 = IngredientVariety.changeset(%IngredientVariety{}, valid_attrs)
    {:ok, _model} = Repo.insert changeset1

    changeset2 = IngredientVariety.changeset(%IngredientVariety{}, valid_attrs)
    {:error, changeset2} = Repo.insert changeset2
    assert changeset2.errors == [name_ingredient_type_id: {"has already been taken", []}]
  end
end
