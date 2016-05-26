defmodule Concoctify.IngredientBrandTest do
  use Concoctify.ModelCase

  alias Concoctify.IngredientBrand

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = IngredientBrand.changeset(%IngredientBrand{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientBrand.changeset(%IngredientBrand{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = IngredientBrand.changeset(%IngredientBrand{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = IngredientBrand.changeset(%IngredientBrand{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: "has already been taken"]
  end
end
