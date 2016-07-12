defmodule Concoctify.IngredientProducerTest do
  use Concoctify.ModelCase

  alias Concoctify.IngredientProducer

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{meow: "cats"}

  test "changeset with valid attributes" do
    changeset = IngredientProducer.changeset(%IngredientProducer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientProducer.changeset(%IngredientProducer{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = IngredientProducer.changeset(%IngredientProducer{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = IngredientProducer.changeset(%IngredientProducer{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: "has already been taken"]
  end
end
