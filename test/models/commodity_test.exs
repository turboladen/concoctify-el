defmodule Concoctify.CommodityTest do
  use Concoctify.ModelCase

  alias Concoctify.Commodity

  @valid_attrs %{base_commodity_id: "7488a646-e31f-11e4-aace-600308960662", commodity_variety_id: "7488a646-e31f-11e4-aace-600308960662", ingredient_producer_id: "7488a646-e31f-11e4-aace-600308960662"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Commodity.changeset(%Commodity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
