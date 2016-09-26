defmodule Concoctify.RecipeTest do
  use Concoctify.ModelCase

  alias Concoctify.Recipe

  @valid_attrs %{description: "some content", directions: "some content", name: "some content", yields_unit: "some content", yields_value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
