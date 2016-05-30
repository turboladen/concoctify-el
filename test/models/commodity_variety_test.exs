defmodule Concoctify.CommodityVarietyTest do
  use Concoctify.ModelCase

  alias Concoctify.CommodityVariety

  @valid_attrs %{base_commodity_id: "7488a646-e31f-11e4-aace-600308960662", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CommodityVariety.changeset(%CommodityVariety{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CommodityVariety.changeset(%CommodityVariety{}, @invalid_attrs)
    refute changeset.valid?
  end
end
