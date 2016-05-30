defmodule Concoctify.HoneyTest do
  use Concoctify.ModelCase

  alias Concoctify.Honey

  @valid_attrs %{honey_variety_id: "7488a646-e31f-11e4-aace-600308960662", ingredient_producer_id: "7488a646-e31f-11e4-aace-600308960662"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Honey.changeset(%Honey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Honey.changeset(%Honey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
