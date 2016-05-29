defmodule Concoctify.CommodityTest do
  use Concoctify.ModelCase

  alias Concoctify.Commodity

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with duplicate name" do
    changeset1 = Commodity.changeset(%Commodity{}, @valid_attrs)
    {:ok, _model} = Concoctify.Repo.insert changeset1

    changeset2 = Commodity.changeset(%Commodity{}, @valid_attrs)
    {:error, changeset2} = Concoctify.Repo.insert changeset2
    assert changeset2.errors == [name: "has already been taken"]
  end
end
