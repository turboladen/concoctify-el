defmodule Concoctify.IngredientTypeTest do
  use Concoctify.ModelCase

  alias Concoctify.IngredientType

  @valid_attrs %{id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = IngredientType.changeset(%IngredientType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientType.changeset(%IngredientType{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = IngredientType.changeset(%IngredientType{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = IngredientType.changeset(%IngredientType{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: {"has already been taken", []}]
  end
end
